#!/bin/bash

set -xe

. /discourse/docker/common.sh

cd /discourse


# note: not resetting the database.
bundle exec rake db:create
bundle exec rake db:migrate
# install seed data for admin account and meta topic.
# XX:this is breaking
# PGPASSWORD=postgres psql -p $POSTGRES_PORT -U root -h $POSTGRES_HOST -d postgres < pg_dumps/production-image.sql

# recompile assets
rm -rf public/*
mv public.oow/* public/
rmdir public.oow
bundle exec rake assets:precompile
