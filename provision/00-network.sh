#!/bin/bash

cat <<EOF > /etc/resolv.conf
nameserver 127.0.0.1 ## dnsmasq
nameserver 1.1.1.1   ## Cloudflare
nameserver 1.0.0.1   ## Cloudflare 2
nameserver 8.8.8.8   ## Google
nameserver 8.8.4.4   ## Google 2
EOF
