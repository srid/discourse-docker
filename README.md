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
* global configuration, and arbitrary run command, for migrating my other forum.

Usage
-----

```bash
# install supervisor
sudo apt-get install python-pip
sudo pip install supervisor

# create docker images
make

# start supervisor (on separate terminal)
make supervisor

# check that redis and postgres are running.
# bin/sup is alias to supervisorctl, with sudo.
bin/sup status  

# setup discourse db and assets
bin/discourse-start setup

# start discourse, sidekiq and nginx
bin/sup start discourse sidekiq nginx

# start discourse workers (separate terminal)
bin/discourse-start bundle exec sidekiq

# view site
make info

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
