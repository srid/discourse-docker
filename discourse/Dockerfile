# -*- sh -*-

# Base image for all Discourse related processes.

FROM ubuntu:12.04
MAINTAINER srid

# TODO: want to upgrade to 0.9.8.11, but database.yml.production-sample no
# longer exists?
ENV DISCOURSE_VERSION 0.9.7.6

ENV RAILS_ENV production

ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

ADD install /

RUN bash -xe /install

ADD	enter /
RUN	chmod +x /enter
WORKDIR   /discourse
ENTRYPOINT ["/enter"]
