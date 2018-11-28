#!/bin/bash

echo "address=/ss/127.0.0.1" >> /etc/dnsmasq.d/php-ss
systemctl stop dhcpcd
systemctl stop dnsmasq
systemctl start dnsmasq
