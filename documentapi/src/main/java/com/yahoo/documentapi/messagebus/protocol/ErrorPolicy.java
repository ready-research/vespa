// Copyright Vespa.ai. Licensed under the terms of the Apache 2.0 license. See LICENSE in the project root.
package com.yahoo.documentapi.messagebus.protocol;

import com.yahoo.messagebus.EmptyReply;
import com.yahoo.messagebus.routing.RoutingContext;

/**
 * This policy assigns an error supplied at constructor time to the routing context when {@link #select(RoutingContext)}
 * is invoked. This is useful for returning error states to the client instead of those auto-generated by mbus when a
 * routing policy can not be created.
 *
 * @author Simon Thoresen Hult
 */
public class ErrorPolicy implements DocumentProtocolRoutingPolicy {

    private final String msg;

    /**
     * Creates a new policy that will assign an {@link EmptyReply} with the given error to all routing contexts that
     * invoke {@link #select(RoutingContext)}.
     *
     * @param msg The message of the error to assign.
     */
    public ErrorPolicy(String msg) {
        this.msg = msg;
    }

    public void select(RoutingContext ctx) {
        ctx.setError(DocumentProtocol.ERROR_POLICY_FAILURE, msg);
    }

    public void merge(RoutingContext ctx) {
        throw new AssertionError("Routing should not pass terminated selection.");
    }

    public void destroy() {
    }
}
