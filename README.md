<!-- -*- mode: Markdown; -*- -->

discourse-docker
================

[Discourse](http://discourse.org/) is a re-imagined online forum
software. Installing Discourse can be quite an involved process. We
use [Docker](http://www.docker.io/), an exciting new container
management tool, to greatly ease the setup process.

Usage
-----

Get yourself a Ubuntu 13.04 VM (I recommend
[DigitalOcean](https://www.digitalocean.com/?refcode=efb0b61918fa)),
and start getting Discourse up and running in a few minutes:

```bash
# install supervisor
sudo apt-get install python-pip
sudo pip install supervisor

# create docker images (takes a few minutes)
make

# start supervisor on a separate terminal window
make supervisor

# verify that redis-server and postgres are running.
# note: bin/sup is alias to `sudo supervisorctl`.
bin/sup status

# setup discourse database and assets
bin/discourse-start setup

# finally, start discourse, sidekiq and nginx
bin/sup start discourse sidekiq nginx

# discourse is now running; launch the discourse URL.
make info

# signup for an account, and make yourself an admin:
bin/make-admin myusername
```

TODO
----

* Setup email
* Parametrize scripts and document workflow
  * Try to emulate `docker run -link`
* Migrate my manually managed Discourse forum.
  * Global configuration (json? etcd?)
* Upcoming docker releases:
  * [#1352: Add support for starting multiple containers from a
    dockerfile](https://github.com/dotcloud/docker/issues/1352) (Docker
    0.8)
  * `docker run -link ...` (no github bug yet)
