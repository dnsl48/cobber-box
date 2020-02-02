#!/bin/bash

DIR="$(readlink -f \"$APP_DIR\")";

if [ ! -z "$RUN_MODE_TEST" ] ; then
    cd $DIR;
    ./vendor/bin/phpunit $@;
    exit;
fi

if [ ! -z "$RUN_MODE_PHPCS" ] ; then
    cd $DIR;
    ./vendor/bin/phpcs --standard=PSR12 bin/ src/ tests/ $@;
    exit;
fi

# $DIR/bin/cow $@