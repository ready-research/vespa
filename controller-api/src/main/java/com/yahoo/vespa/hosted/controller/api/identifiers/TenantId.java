// Copyright 2017 Yahoo Holdings. Licensed under the terms of the Apache 2.0 license. See LICENSE in the project root.
package com.yahoo.vespa.hosted.controller.api.identifiers;

/**
 * @author smorgrav
 */
public class TenantId extends NonDefaultIdentifier {

    public TenantId(String id) {
        super(id);
    }

    @Override
    public void validate() {
        super.validate();
        validateNoUpperCase();
    }

    public static void validate(String id) {
        if ( ! strictPattern.matcher(id).matches())
            throwInvalidId(id, strictPatternExplanation);
        new TenantId(id); // validate
    }

}
