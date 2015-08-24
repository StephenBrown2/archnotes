#!/bin/bash
GATEWAYS=(vpn1.dfw1.rackspace.com vpn1.hkg1.rackspace.com vpn1.iad1.rackspace.com vpn1.iad3.rackspace.com vpn1.lon3.rackspace.com vpn1.lon5.rackspace.com vpn1.ord1.rackspace.com vpn1.syd1.rackspace.com vpn1.syd2.rackspace.com vpn2.iad3.rackspace.com vpn2.lon5.rackspace.com)
for gateway in "${GATEWAYS[@]}"; do
    DC=${gateway%.rackspace.com}
    TEMPLATE="IKE Authmode psk
IKE DH Group dh2
Xauth username step7212
IPSec secret rackspace
IPSec ID rackspace
IPSec gateway ${gateway}
"
    echo "$TEMPLATE" | sudo tee "/etc/vpnc/${DC}.conf"
    chown root:root /etc/vpnc/${DC}.conf
    chmod 600 /etc/vpnc/${DC}.conf
done