#!/bin/bash


SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
    TARGET="$(readlink "$SOURCE")"
    if [[ $TARGET == /* ]]; then
        echo "SOURCE '$SOURCE' is an absolute symlink to '$TARGET'"
        SOURCE="$TARGET"
    else
        DIR="$( dirname "$SOURCE" )"
        echo "SOURCE '$SOURCE' is a relative symlink to '$TARGET' (relative to '$DIR')"
        SOURCE="$DIR/$TARGET" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
    fi
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

CONFIGS_PATH="$DIR/compose"

CONFIGS=""
for c in $(ls $CONFIGS_PATH/*.yml); do
    CONFIGS="$CONFIGS -f $c";
done


COMPOSE_PROJECT_NAME=ossbox

sudo sysctl net.ipv4.conf.all.forwarding=1
sudo iptables -P FORWARD ACCEPT

docker-compose $CONFIGS $@
