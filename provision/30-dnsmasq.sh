#!/bin/bash

echo "address=/ss/127.0.0.1" >> /etc/dnsmasq.d/php-ss
echo "address=/nip.io/127.0.0.1" >> /etc/dnsmasq.d/php-ss

systemctl stop dnsmasq
systemctl start dnsmasq
systemctl enable dnsmasq
