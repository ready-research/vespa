// Copyright Verizon Media. Licensed under the terms of the Apache 2.0 license. See LICENSE in the project root.
package com.yahoo.vespa.config.server;

import com.yahoo.vespa.config.server.tenant.TenantListener;

/**
 * Interface representing all global config server components used within the config server.
 *
 * @author Ulf Lilleengen
 */
public interface GlobalComponentRegistry {

    TenantListener getTenantListener();
    ReloadListener getReloadListener();
}
