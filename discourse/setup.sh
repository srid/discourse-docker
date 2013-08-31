#!/bin/bash

set -xe

. /discourse/docker/common.sh

cd /discourse

# clean up the data volumes before fresh setup.
rm -rf public/*

mv public.oow/* public/
rmdir public.oow

# note: not resetting the database.
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake assets:precompile
