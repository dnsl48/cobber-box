#!/bin/bash

vagrant up && vagrant ssh -c "nc -v -lk 192.168.3.1 9000 -c '/usr/bin/nc localhost 9000' & nc -v -lk 192.168.1.1 9515 -c '/usr/bin/nc localhost 9515' & ./docker/run.sh up" -- -R 9000:localhost:9000 -R 9515:localhost:9515
