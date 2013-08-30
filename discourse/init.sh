#!/bin/bash
# Initialize Discourse configuration with docker-set environment
# variables:
#  $POSTGRES_HOST
#  $POSTGRES_PORT

set -xe

cd /discourse

# production database
sed -i "s/database: discourse_prod/database: postgres/" config/database.yml
sed -i "s/# username: discourse_prod/username: root/" config/database.yml
sed -i "s/# password: itisagooddaytovi/password: postgres/" config/database.yml
sed -i "s/# host: dbhost/host: $POSTGRES_HOST\n  port: $POSTGRES_PORT/" config/database.yml

# test db
sed -i "s/# username: discourse_test/username: root/" config/database.yml
sed -i "s/# password: 123123123123/password: postgres/" config/database.yml
sed -i "s/# host: localhost/host: $POSTGRES_HOST\n  port: $POSTGRES_PORT/" config/database.yml

echo "database.yml =>"
cat config/database.yml

exec bash -c "$@"
