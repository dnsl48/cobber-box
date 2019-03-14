#!/bin/sh

yum update -y
yum install -y epel-release
yum install -y inotify-tools git wget bind-utils mg vim nmap-ncat htop httpie dnsmasq PyYAML
