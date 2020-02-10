#!/bin/bash

if [ ! -z "$ENTRY_PHPUNIT" ] ; then
    cd $APP_DIR;
    ./vendor/bin/phpunit $@
    exit;
fi

if [ ! -z "$ENTRY_PHPCS" ] ; then
    cd $APP_DIR;
    ./vendor/bin/phpcs -p $@
    exit;
fi

cd $APP_DIR;
./vendor/bin/$1 ${@:2}
