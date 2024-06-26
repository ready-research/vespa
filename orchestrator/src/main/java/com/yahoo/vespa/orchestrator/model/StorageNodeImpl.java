// Copyright Vespa.ai. Licensed under the terms of the Apache 2.0 license. See LICENSE in the project root.
package com.yahoo.vespa.orchestrator.model;

import com.yahoo.vespa.applicationmodel.ApplicationInstance;
import com.yahoo.vespa.applicationmodel.ClusterId;
import com.yahoo.vespa.applicationmodel.HostName;
import com.yahoo.vespa.applicationmodel.ServiceInstance;
import com.yahoo.vespa.orchestrator.OrchestratorContext;
import com.yahoo.vespa.orchestrator.controller.ClusterControllerClient;
import com.yahoo.vespa.orchestrator.controller.ClusterControllerClientFactory;
import com.yahoo.vespa.orchestrator.controller.ClusterControllerNodeState;
import com.yahoo.vespa.orchestrator.policy.HostStateChangeDeniedException;
import java.util.List;
import java.util.Objects;
import java.util.logging.Level;
import java.util.logging.Logger;

public class StorageNodeImpl implements StorageNode {
    private static final Logger logger = Logger.getLogger(StorageNodeImpl.class.getName());

    private final ApplicationInstance applicationInstance;
    private final ClusterId clusterId;
    private final ServiceInstance storageService;
    private final ClusterControllerClientFactory clusterControllerClientFactory;

    StorageNodeImpl(ApplicationInstance applicationInstance,
                    ClusterId clusterId,
                    ServiceInstance storageService,
                    ClusterControllerClientFactory clusterControllerClientFactory) {
        this.applicationInstance = applicationInstance;
        this.clusterId = clusterId;
        this.storageService = storageService;
        this.clusterControllerClientFactory = clusterControllerClientFactory;
    }

    @Override
    public HostName hostName() {
        return storageService.hostName();
    }

    @Override
    public void setStorageNodeState(OrchestratorContext context, ClusterControllerNodeState wantedNodeState)
            throws HostStateChangeDeniedException {
        setNodeState(context, wantedNodeState, ContentService.STORAGE_NODE, false);
    }

    @Override
    public void forceDistributorState(OrchestratorContext context, ClusterControllerNodeState wantedState) throws HostStateChangeDeniedException {
        setNodeState(context, wantedState, ContentService.DISTRIBUTOR, true);
    }

    public void setNodeState(OrchestratorContext context, ClusterControllerNodeState wantedNodeState, ContentService contentService, boolean force)
            throws HostStateChangeDeniedException {
        // The "cluster name" used by the Cluster Controller IS the cluster ID.
        String clusterId = this.clusterId.s();

        List<HostName> clusterControllers = VespaModelUtil.getClusterControllerInstancesInOrder(applicationInstance, this.clusterId);

        ClusterControllerClient client = clusterControllerClientFactory.createClient(
                clusterControllers,
                clusterId);

        int nodeIndex = VespaModelUtil.getStorageNodeIndex(storageService.configId());

        logger.log(Level.FINE, () -> (force ? "Force" : "Safe") +
                                     " setting cluster controller state for " +
                                     "application " + applicationInstance.reference().asString() +
                                     ", host " + hostName() +
                                     ", cluster name " + clusterId +
                                     ", service " + contentService.nameInClusterController() +
                                     ", node index " + nodeIndex +
                                     ", node state " + wantedNodeState);

        client.setNodeState(context, storageService.hostName(), nodeIndex, wantedNodeState, contentService, force);
    }

    @Override
    public String toString() {
        return "StorageNodeImpl{" +
                "applicationInstance=" + applicationInstance.reference() +
                ", clusterId=" + clusterId +
                ", storageService=" + storageService +
                '}';
    }

    /** Only base it on the service instance, e.g. the cluster ID is included in its equals(). */
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof StorageNodeImpl that)) return false;
        return Objects.equals(storageService, that.storageService);
    }

    @Override
    public int hashCode() {
        return Objects.hash(storageService);
    }

    @Override
    public int compareTo(StorageNode otherStorageNode) {
        if (!(otherStorageNode instanceof StorageNodeImpl that)) {
            throw new IllegalArgumentException("Unable to compare our class to any StorageNode object");
        }

        // We're guaranteed there's only one storage service per node.
        return this.storageService.hostName().compareTo(that.storageService.hostName());
    }
}
