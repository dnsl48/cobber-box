#!/bin/bash

echo "/home/vagrant/docker/run.sh run --rm -w$(pwd) php$1cow cow -vvv ${@:2}"
/home/vagrant/docker/run.sh run --rm -w$(pwd) php$1cow cow -vvv ${@:2}
