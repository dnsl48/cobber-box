#!/bin/bash

vagrant up && vagrant ssh -c "nc -v -lk 192.168.3.1 9000 -c '/usr/bin/nc localhost 9000' & ./docker/run.sh up" -- -R 9000:localhost:9000
