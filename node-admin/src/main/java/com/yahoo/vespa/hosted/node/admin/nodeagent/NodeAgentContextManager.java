// Copyright 2019 Yahoo Holdings. Licensed under the terms of the Apache 2.0 license. See LICENSE in the project root.
package com.yahoo.vespa.hosted.node.admin.nodeagent;

import java.time.Clock;
import java.time.Duration;
import java.time.Instant;
import java.util.Objects;

/**
 * This class should be used by exactly 2 thread, 1 for each interface it implements.
 *
 * @author freva
 */
public class NodeAgentContextManager implements NodeAgentContextSupplier, NodeAgentScheduler {

    private final Object monitor = new Object();
    private final Clock clock;

    private NodeAgentContext currentContext;
    private NodeAgentContext nextContext;
    private Instant nextContextAt;
    private boolean wantFrozen = false;
    private boolean isFrozen = true;
    private boolean pendingInterrupt = false;
    private boolean isWaitingForNextContext = false;

    public NodeAgentContextManager(Clock clock, NodeAgentContext context) {
        this.clock = clock;
        this.currentContext = context;
    }

    @Override
    public void scheduleTickWith(NodeAgentContext context, Instant at) {
        synchronized (monitor) {
            nextContext = Objects.requireNonNull(context);
            nextContextAt = Objects.requireNonNull(at);
            monitor.notifyAll(); // Notify of new context
        }
    }

    @Override
    public boolean setFrozen(boolean frozen, Duration timeout) {
        synchronized (monitor) {
            if (wantFrozen != frozen) {
                wantFrozen = frozen;
                monitor.notifyAll(); // Notify the supplier of the wantFrozen change
            }

            boolean successful;
            long remainder;
            long end = clock.instant().plus(timeout).toEpochMilli();
            while (!(successful = isFrozen == frozen) && (remainder = end - clock.millis()) > 0) {
                try {
                    monitor.wait(remainder); // Wait with timeout until the supplier is has reached wanted frozen state
                } catch (InterruptedException ignored) { }
            }

            return successful;
        }
    }

    @Override
    public NodeAgentContext nextContext() throws InterruptedException {
        synchronized (monitor) {
            nextContext = null; // Reset any previous context and wait for the next one
            isWaitingForNextContext = true;
            monitor.notify();
            Duration untilNextContext = Duration.ZERO;
            while (setAndGetIsFrozen(wantFrozen) ||
                    nextContext == null ||
                    (untilNextContext = Duration.between(Instant.now(), nextContextAt)).toMillis() > 0) {
                if (pendingInterrupt) {
                    pendingInterrupt = false;
                    throw new InterruptedException("interrupt() was called before next context was scheduled");
                }

                try {
                    monitor.wait(Math.max(untilNextContext.toMillis(), 0L)); // Wait until scheduler provides a new context
                } catch (InterruptedException ignored) { }
            }

            isWaitingForNextContext = false;
            currentContext = nextContext;
            return currentContext;
        }
    }

    @Override
    public NodeAgentContext currentContext() {
        synchronized (monitor) {
            return currentContext;
        }
    }

    @Override
    public void interrupt() {
        synchronized (monitor) {
            pendingInterrupt = true;
            monitor.notifyAll();
        }
    }

    private boolean setAndGetIsFrozen(boolean isFrozen) {
        synchronized (monitor) {
            if (this.isFrozen != isFrozen) {
                this.isFrozen = isFrozen;
                monitor.notifyAll(); // Notify the scheduler of the isFrozen change
            }
            return this.isFrozen;
        }
    }

    /** FOR TESTING ONLY */
    void waitUntilWaitingForNextContext() {
        synchronized (monitor) {
            while (!isWaitingForNextContext) {
                try {
                    monitor.wait();
                } catch (InterruptedException ignored) { }
            }
        }
    }
}