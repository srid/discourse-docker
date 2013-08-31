#!/bin/bash

set -xe

. /discourse/docker/common.sh

cd /discourse

exec bash -c "$@"
