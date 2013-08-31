<!-- -*- mode: Markdown; -*- -->

discourse-docker
================

Dockerize [Discourse](http://discourse.org/). This is work in
progress.

Original setup instructions,
https://github.com/discourse/discourse/blob/master/docs/INSTALL-ubuntu.md

Past success (manual setup),
https://github.com/srid/notes/blob/master/discourse-on-ubuntu.md

TODO
----

* setup email
* parametrize scripts and document workflow
  * can i emulate -link before it is released?
* process supervisor
* global configuration, and arbitrary run command, for migrating my other forum.

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

# start discourse (separate terminal)
bin/discourse-start 

# start discourse workers (separate terminal)
bin/discourse-start bundle exec sidekiq

# start nginx front
bin/nginx-start

# view site
bin/nginx-info

# signup for an account, and make yourself an admin:
bin/postgresql-info
echo UPDATE users SET admin = true WHERE username = \'srid\'\; | PGPASSWORD=postgres psql -p 5432 -U root -h 172.17.0.12 -d postgres
```

docker feature requests
-----------------------

* [#1352: Add support for starting multiple containers from a
  dockerfile](https://github.com/dotcloud/docker/issues/1352) (Docker
  0.8)

* `docker run -link ...` (no github bug yet)
