#!/bin/bash

echo "/home/vagrant/docker/run.sh run --rm -w$(pwd) mysqlcli$1 ${@:2}"
/home/vagrant/docker/run.sh run --rm -w$(pwd) mysqlcli$1 ${@:2}
