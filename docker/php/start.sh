#!/bin/bash
APP_PATH=/app/$APP_NAME
# Check if project folder exists
if [[ ! -d $APP_PATH ]]; then
    # Folder doesn't exist this is a new install
    composer create-project --prefer-dist laravel/laravel $APP_NAME "$APP_VER" && \
    cd $APP_NAME && \
    composer require "hhxsv5/laravel-s:~3.7.0" -vvv && \
    echo 'LARAVELS_LISTEN_IP=${APP_HOST}' >> .env && \
    echo 'LARAVELS_LISTEN_PORT=${APP_PORT}' >> .env && \
    # Publish laravels config
    php artisan laravels publish 
else
    cd $APP_NAME
fi

if [[ ! -d "vendor/" ]]; then
    # If vendor folder is not there install it using composer
    composer install
fi

# Remove laravels files if theres any to prevent a bug.
rm -rf storage/laravels.*

if [[ $APP_RUN -eq "swoole" ]]; then
    # Start swoole if it is demanded via enviroment variables.
    php $APP_PATH/bin/laravels start
else
    # Start Laravel webserver if swoole is not demanded.
    php artisan serve --port=$APP_PORT --host=$APP_HOST
fi
