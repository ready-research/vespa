// Copyright Yahoo. Licensed under the terms of the Apache 2.0 license. See LICENSE in the project root.
package ai.vespa.feed.client.impl;

import ai.vespa.feed.client.DocumentId;
import ai.vespa.feed.client.FeedClient;
import ai.vespa.feed.client.FeedException;
import ai.vespa.feed.client.HttpResponse;
import ai.vespa.feed.client.OperationParameters;
import ai.vespa.feed.client.OperationStats;
import ai.vespa.feed.client.Result;
import ai.vespa.feed.client.ResultException;
import ai.vespa.feed.client.ResultParseException;
import com.fasterxml.jackson.core.JsonFactory;
import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.core.JsonToken;

import java.io.IOException;
import java.io.UncheckedIOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.time.Duration;
import java.util.HashMap;
import java.util.Map;
import java.util.StringJoiner;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.CompletionException;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.TimeoutException;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.function.Supplier;

import static ai.vespa.feed.client.OperationParameters.empty;
import static java.nio.charset.StandardCharsets.UTF_8;
import static java.util.Objects.requireNonNull;

/**
 * HTTP implementation of {@link FeedClient}
 *
 * @author bjorncs
 * @author jonmv
 */
class HttpFeedClient implements FeedClient {

    private static final JsonFactory factory = new JsonFactory();

    private final Map<String, Supplier<String>> requestHeaders;
    private final RequestStrategy requestStrategy;
    private final AtomicBoolean closed = new AtomicBoolean();
    private final boolean speedTest;

    HttpFeedClient(FeedClientBuilderImpl builder) throws IOException {
        this(builder, new HttpRequestStrategy(builder));
    }

    HttpFeedClient(FeedClientBuilderImpl builder, RequestStrategy requestStrategy) {
        this.requestHeaders = new HashMap<>(builder.requestHeaders);
        this.requestStrategy = requestStrategy;
        this.speedTest = builder.speedTest;
        verifyConnection(builder);
    }

    @Override
    public CompletableFuture<Result> put(DocumentId documentId, String documentJson, OperationParameters params) {
        return send("POST", documentId, requireNonNull(documentJson), params);
    }

    @Override
    public CompletableFuture<Result> update(DocumentId documentId, String updateJson, OperationParameters params) {
        return send("PUT", documentId, requireNonNull(updateJson), params);
    }

    @Override
    public CompletableFuture<Result> remove(DocumentId documentId, OperationParameters params) {
        return send("DELETE", documentId, null, params);
    }

    @Override
    public OperationStats stats() {
        return requestStrategy.stats();
    }

    @Override
    public CircuitBreaker.State circuitBreakerState() {
        return requestStrategy.circuitBreakerState();
    }

    @Override
    public void close(boolean graceful) {
        closed.set(true);
        if (graceful)
            requestStrategy.await();

        requestStrategy.destroy();
    }

    private CompletableFuture<Result> send(String method, DocumentId documentId, String operationJson, OperationParameters params) {
        if (closed.get())
            throw new IllegalStateException("Client is closed");

        HttpRequest request = new HttpRequest(method,
                                              getPath(documentId) + getQuery(params, speedTest),
                                              requestHeaders,
                                              operationJson == null ? null : operationJson.getBytes(UTF_8), // TODO: make it bytes all the way?
                                              params.timeout().orElse(null));

        CompletableFuture<Result> promise = new CompletableFuture<>();
        requestStrategy.enqueue(documentId, request)
                       .thenApply(response -> toResult(request, response, documentId))
                       .whenComplete((result, thrown) -> {
                           if (thrown != null) {
                               while (thrown instanceof CompletionException)
                                   thrown = thrown.getCause();

                               promise.completeExceptionally(thrown);
                           }
                           else
                               promise.complete(result);
                       });
        return promise;
    }

    private void verifyConnection(FeedClientBuilderImpl builder) {
        if (builder.dryrun) return;
        try (Cluster cluster = new ApacheCluster(builder)) {
            HttpRequest request = new HttpRequest("POST",
                                                  getPath(DocumentId.of("feeder", "handshake", "dummy")) + getQuery(empty(), true),
                                                  requestHeaders,
                                                  null,
                                                  Duration.ofSeconds(10));
            CompletableFuture<HttpResponse> future = new CompletableFuture<>();
            cluster.dispatch(request, future);
            HttpResponse response = future.get(20, TimeUnit.SECONDS);
            if (response.code() != 200) {
                String message = switch (response.contentType()) {
                    case "application/json" -> parseMessage(request.body());
                    case "text/plain" -> new String(request.body(), UTF_8);
                    default -> response.toString();
                };
                throw new FeedException("server responded non-OK to handshake: " + message);
            }
        }
        catch (IOException e) {
            throw new FeedException("failed initiating handshake with server: " + e, e);
        }
        catch (ExecutionException e) {
            throw new FeedException("failed handshake with server: " + e.getCause(), e.getCause());
        }
        catch (InterruptedException e) {
            Thread.currentThread().interrupt();
            throw new FeedException("interrupted during handshake with server", e);
        }
        catch (TimeoutException e) {
            throw new FeedException("timed out during handshake with server", e);
        }
    }

    private static String parseMessage(byte[] json) {
        try {
            return parse(null, json).message;
        }
        catch (Exception e) {
            return new String(json, UTF_8);
        }
    }

    private enum Outcome { success, conditionNotMet, vespaFailure, transportFailure };

    static Result.Type toResultType(Outcome outcome) {
        return switch (outcome) {
            case success -> Result.Type.success;
            case conditionNotMet -> Result.Type.conditionNotMet;
            default -> throw new IllegalArgumentException("No corresponding result type for '" + outcome + "'");
        };
    }

    record MessageAndTrace(String message, String trace) { }

    static MessageAndTrace parse(DocumentId documentId, byte[] json) {
        String message = null;
        String trace = null;
        try (JsonParser parser = factory.createParser(json)) {
            if (parser.nextToken() != JsonToken.START_OBJECT)
                throw new ResultParseException(
                        documentId,
                        "Expected '" + JsonToken.START_OBJECT + "', but found '" + parser.currentToken() + "' in: " +
                        new String(json, UTF_8));

            String name;
            while ((name = parser.nextFieldName()) != null) {
                switch (name) {
                    case "message" -> message = parser.nextTextValue();
                    case "trace" -> {
                        if (parser.nextToken() != JsonToken.START_ARRAY)
                            throw new ResultParseException(documentId,
                                                           "Expected 'trace' to be an array, but got '" + parser.currentToken() + "' in: " +
                                                           new String(json, UTF_8));
                        int start = (int) parser.getTokenLocation().getByteOffset();
                        int depth = 1;
                        while (depth > 0) switch (parser.nextToken()) {
                            case START_ARRAY -> ++depth;
                            case END_ARRAY -> --depth;
                        }
                        int end = (int) parser.getTokenLocation().getByteOffset() + 1;
                        trace = new String(json, start, end - start, UTF_8);
                    }
                    default -> parser.nextToken();
                }
            }

            if (parser.currentToken() != JsonToken.END_OBJECT)
                throw new ResultParseException(
                        documentId,
                        "Expected '" + JsonToken.END_OBJECT + "', but found '" + parser.currentToken() + "' in: "
                        + new String(json, UTF_8));
        }
        catch (IOException e) {
            throw new ResultParseException(documentId, e);
        }

        return new MessageAndTrace(message, trace);
    }

    static Result toResult(HttpRequest request, HttpResponse response, DocumentId documentId) {
        Outcome outcome = switch (response.code()) {
            case 200 -> Outcome.success;
            case 412 -> Outcome.conditionNotMet;
            case 502, 504, 507 -> Outcome.vespaFailure;
            default -> Outcome.transportFailure;
        };

        MessageAndTrace mat = parse(documentId, response.body());

        if (outcome == Outcome.transportFailure) // Not a Vespa response, but a failure in the HTTP layer.
            throw new FeedException(
                    documentId,
                    "Status " + response.code() + " executing '" + request + "': "
                            + (mat.message == null ? new String(response.body(), UTF_8) : mat.message));

        if (outcome == Outcome.vespaFailure)
            throw new ResultException(documentId, mat.message, mat.trace);

        return new ResultImpl(toResultType(outcome), documentId, mat.message, mat.trace);
    }

    static String getPath(DocumentId documentId) {
        StringJoiner path = new StringJoiner("/", "/", "");
        path.add("document");
        path.add("v1");
        path.add(encode(documentId.namespace()));
        path.add(encode(documentId.documentType()));
        if (documentId.number().isPresent()) {
            path.add("number");
            path.add(Long.toUnsignedString(documentId.number().getAsLong()));
        }
        else if (documentId.group().isPresent()) {
            path.add("group");
            path.add(encode(documentId.group().get()));
        }
        else {
            path.add("docid");
        }
        path.add(encode(documentId.userSpecific()));

        return path.toString();
    }

    static String encode(String raw) {
        try {
            return URLEncoder.encode(raw, UTF_8.name());
        }
        catch (UnsupportedEncodingException e) {
            throw new IllegalStateException(e);
        }
    }

    static String getQuery(OperationParameters params, boolean speedTest) {
        StringJoiner query = new StringJoiner("&", "?", "").setEmptyValue("");
        if (params.createIfNonExistent()) query.add("create=true");
        params.testAndSetCondition().ifPresent(condition -> query.add("condition=" + encode(condition)));
        params.timeout().ifPresent(timeout -> query.add("timeout=" + timeout.toMillis() + "ms"));
        params.route().ifPresent(route -> query.add("route=" + encode(route)));
        params.tracelevel().ifPresent(tracelevel -> query.add("tracelevel=" + tracelevel));
        if (speedTest) query.add("dryRun=true");
        return query.toString();
    }

}
