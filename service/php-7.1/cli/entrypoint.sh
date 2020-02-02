#!/bin/bash

if [ ! -z "$RUN_MODE_TEST" ] ; then
    cd $APP_DIR;
    ./vendor/bin/phpunit $@
    exit;
fi

cd $APP_DIR;
./vendor/bin/$1 ${@:2}

# $DIR/bin/cow $@