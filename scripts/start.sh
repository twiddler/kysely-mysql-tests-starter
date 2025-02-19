#!/bin/bash

echo "Starting podman container …"
podman run \
    --name mysql \
    --rm \
    -d \
    -p 3306:3306 \
    -e MYSQL_ROOT_PASSWORD=root \
    -e MYSQL_DATABASE=test \
    --health-cmd "mysql --user=root --password=root --host=127.0.0.1 --execute='SELECT 1'" \
    --health-interval=1s \
    --health-timeout=1s \
    --health-retries=15 \
    docker.io/library/mysql

echo "Waiting for mysqld to accept connections. This might take some seconds …"
podman wait --condition healthy mysql
