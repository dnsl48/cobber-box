#!/bin/bash

mkdir -p /home/vagrant/.cache/.composer/cache
mkdir -p /home/vagrant/.cache/.npm
mkdir -p /home/vagrant/.cache/yarn

chown -R vagrant:vagrant /home/vagrant/.cache
