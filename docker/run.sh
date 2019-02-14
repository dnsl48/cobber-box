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

CONFIG_FILES=""
CONFIGS=""
for c in $(ls $CONFIGS_PATH/*.yml); do
    CONFIGS="$CONFIGS -f $c";
    CONFIG_FILES="$CONFIG_FILES $c"
done

COMPOSE_PROJECT_NAME=ossbox
CPU_NUM=$(grep processor /proc/cpuinfo | wc -l)

sudo sysctl net.ipv4.conf.all.forwarding=1
sudo iptables -P FORWARD ACCEPT

if [[ $@ == "build" ]] ; then
    echo "Rebuilding everything!";
    # read all service names from the composer configs and print them out one by one for a row
    # then pass it to xargs to perform parallel build for the services
    python -c 'import yaml; import sys; fls=sys.argv[-1]; print("\n".join([item for sublist in [d["services"].keys() for d in [yaml.load(open(f, "r")) for f in fls.split()] if d.has_key("services")] for item in sublist]))' "$CONFIG_FILES" | xargs -P$CPU_NUM -I% -t docker-compose $CONFIGS build % ;

else
    docker-compose $CONFIGS $@ ;
fi;
