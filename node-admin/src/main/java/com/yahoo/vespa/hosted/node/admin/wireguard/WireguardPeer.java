package com.yahoo.vespa.hosted.node.admin.wireguard;

import com.yahoo.config.provision.HostName;
import com.yahoo.config.provision.WireguardKey;
import com.yahoo.vespa.hosted.node.admin.task.util.network.VersionedIpAddress;

import java.util.List;
import java.util.Optional;

/**
 * A wireguard peer.
 *
 * @author gjoranv
 */
public record WireguardPeer(HostName hostname,
                            List<VersionedIpAddress> ipAddresses,
                            Optional<WireguardKey> publicKey) implements Comparable<WireguardPeer> {

    public WireguardPeer {
        if (ipAddresses.isEmpty()) throw new IllegalArgumentException("No IP addresses for peer node " + hostname.value());
        ipAddresses = ipAddresses.stream().sorted().toList();
    }

    @Override
    public int compareTo(WireguardPeer o) {
        return hostname.value().compareTo(o.hostname.value());
    }

}