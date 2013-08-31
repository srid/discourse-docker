#!/bin/bash

set -xe

. /discourse/docker/common.sh

cd /discourse

echo "RAILS_ENV: $RAILS_ENV"
echo "$@" | exec bash
