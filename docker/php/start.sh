#!/bin/bash

APP_PATH=/app/$APP_NAME

if [[ ! -d $APP_PATH ]]; then

    composer create-project --prefer-dist laravel/laravel $APP_NAME "$APP_VER" && \
    cd $APP_NAME && \
    composer require "hhxsv5/laravel-s:~3.7.0" -vvv && \
    echo 'LARAVELS_LISTEN_IP=${APP_HOST}' >> .env && \
    echo 'LARAVELS_LISTEN_PORT=${APP_PORT}' >> .env && \

    php artisan laravels publish 

fi

cd $APP_NAME

if [[ $APP_RUN -eq "swoole" ]]; then
    php bin/laravels start
else
    php artisan serve --port=$APP_PORT --host=$APP_HOST
fi
# --host="0.0.0.0" --port="80"