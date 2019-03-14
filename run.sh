#!/bin/bash

# chromedriver --port=9515 --whitelisted-ips='192.168.10.10,127.0.0.1' &
# CHROMEDRIVER_PID=$!

vagrant up && vagrant ssh -c "nc -v -lk 192.168.3.1 9000 -c '/usr/bin/nc localhost 9000' & nc -v -lk 192.168.1.1 9515 -c '/usr/bin/nc localhost 9515' & ./docker/run.sh up" -- -R 9000:localhost:9000 -R 9515:localhost:9515

# trap "echo 'Killing the chromedriver ($CHROMEDRIVER_PID)'; kill -15 $CHROMEDRIVER_PID;" INT QUIT TERM EXIT
# wait $CHROMEDRIVER_PID
