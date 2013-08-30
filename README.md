discourse-docker
================

Dockerize [Discourse](http://discourse.org/). This is work in
progress.

Approach
--------

There will be multiple docker images, roughly one for:

* Discourse image
* postgresql image
* redis image

The discourse image will be run multiple times, one for web process,
some more for workers (email, etc.). 

This is not finalized yet.

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

* Get a MVP working
* Email
