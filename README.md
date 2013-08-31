discourse-docker
================

Dockerize [Discourse](http://discourse.org/). This is work in
progress.

Whiteboard
----------

Running multiple processes,

* [#1352: Add support for starting multiple containers from a
  dockerfile](https://github.com/dotcloud/docker/issues/1352) (Docker
  0.8)
* Container orchestration for Docker environments;
  [maestro](https://github.com/toscanini/maestro) is in "early
  development" and its config file format is changing heavily.

Original setup instructions,
https://github.com/discourse/discourse/blob/master/docs/INSTALL-ubuntu.md

Past success (manual setup),
https://github.com/srid/notes/blob/master/discourse-on-ubuntu.md

TODO
----

* initial seed data
* run workers
* setup email
* parametrize scripts and document workflow

Usage
-----

```bash
# create docker images
make

# spawn redis, postgres
sudo docker run -d srid/redis:2.6
bin/postgresql-start

# setup discourse db and assets
bin/discourse-start setup

# start discourse
bin/discourse-start 

# start nginx front
bin/nginx-start

# view site
bin/nginx-info
```