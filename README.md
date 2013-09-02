<!-- -*- mode: Markdown; -*- -->

discourse-docker
================

[Discourse](http://discourse.org/) is a re-imagined online forum
software. Installing Discourse can be quite an involved process. We
use [Docker](http://www.docker.io/), an exciting new container
management tool, to greatly ease its install process.

Usage
-----

Get yourself a Ubuntu 13.04 VM (I recommend
[DigitalOcean](https://www.digitalocean.com/?refcode=efb0b61918fa)),
and start getting Discourse up and running in a few minutes:

```bash
# install docker
open http://docs.docker.io/en/latest/installation/ubuntulinux/#ubuntu-raring

# install supervisor
sudo apt-get install python-pip
sudo pip install supervisor

# create docker images (takes a few minutes)
make

# Configure your discourse site domain (DISCOURSE_HOST)
more etc/env
echo 'export DISCOURSE_HOST=mysite.com:5000' > .env

# OPTIONAL: email support via postmarkapp.com.
# later, add the 'From' address to Discourse admin settings.
echo 'export POSTMARK_API_KEY=<apikey>' >> .env

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

* Publish to the public registry
  * How to publish meta files (bin/, etc/)?
  * Prefer `docker run` over `bin/*`
    * Can't move ENV (link) and VOLUME to Dockerfile.
    
* Backup script (dropbox) for postgres and uploads folder

* Upgrade script for upgrading to discourse future tag releases
  * Automatically backup/restore data/{postgresql/discourse-public} in
    the event if failure.
  * Run db:migrate and asset:precompile without resetting
    data/discourse-public (as 'setup' does).

* Monitor upcoming docker releases:
  * [#1352: Add support for starting multiple containers from a
    dockerfile](https://github.com/dotcloud/docker/issues/1352) (Docker
    0.8)
  * `docker run -link ...` (no github bug yet)

Migration
---------

To migrate an existing Discourse forum:

0. Start only postgresql,redis

1. Take a snapshot of the database and import it right after starting
   the postgresql image.
   
2. Run `bin/discourse-start setup`. If assets creation fails, try
   re-running it using `bin/discourse-start "bundle exec rake
   assets:precompile"`.
   
3. TODO: import public/uploads/

