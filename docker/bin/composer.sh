#!/bin/bash

COMPOSER_PROCESS_TIMEOUT=600

echo "/home/vagrant/docker/run.sh run --rm -w$(pwd) php$1 composer -vvv ${@:2}"
/home/vagrant/docker/run.sh run --rm -w$(pwd) php$1 composer -vvv ${@:2}
