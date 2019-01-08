#!/bin/bash

echo "/home/vagrant/docker/run.sh run --rm -w$(pwd) php$1 ${@:2}"
/home/vagrant/docker/run.sh run --rm -w$(pwd) php$1 ${@:2}
