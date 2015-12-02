#!/usr/bin/env bash

swift-ring-builder account.builder create 18 3 1
swift-ring-builder container.builder create 18 3 1
swift-ring-builder object.builder create 18 3 1

{% for server, addrs in salt['mine.get']('roles:swift_object', 'network.ip_addrs', 'grain' ).items() %}
swift-ring-builder account.builder add r0z1-{{ addrs[0] }}:6002/loop2 10
swift-ring-builder container.builder add r0z1-{{ addrs[0] }}:6001/loop2 10
swift-ring-builder object.builder add r0z1-{{ addrs[0] }}:6000/loop2 10
{% endfor %}

swift-ring-builder account.builder
swift-ring-builder container.builder
swift-ring-builder object.builder

swift-ring-builder account.builder rebalance
swift-ring-builder container.builder rebalance
swift-ring-builder object.builder rebalance






