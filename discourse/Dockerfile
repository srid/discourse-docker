# -*- sh -*-

# Base image for all Discourse related processes.

# NOTE to dev: do not have too many RUN commands; see
# https://github.com/dotcloud/docker/issues/1171


FROM ubuntu:12.04
MAINTAINER srid

ENV DISCOURSE_VERSION 0.9.6.2

RUN apt-get -qy update && apt-get -qy install git 

# Get discourse stable tag
RUN git clone --depth 1 https://github.com/discourse/discourse.git && cd discourse && git checkout v$DISCOURSE_VERSION

# We don't care about having .git on an ephemeral filesystem.
RUN rm -rf .git

# https://bugs.launchpad.net/ubuntu/+source/lxc/+bug/813398
RUN apt-get -qy install language-pack-en 

ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
RUN locale-gen en_US.UTF-8
RUN dpkg-reconfigure locales

# The setup commands belong adhere to the official instructions at,
# https://github.com/discourse/discourse/blob/master/docs/INSTALL-ubuntu.md
#

RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list && apt-get -qy update
RUN apt-get -qy install build-essential libssl-dev libyaml-dev git libtool libxslt-dev libxml2-dev libpq-dev gawk curl pngcrush imagemagick python-software-properties

# Discourse setup
#

# Create discourse database
# XXX: we are struck here, as docker won't run installed services, for
# good reason. need to look into having multiple Dockerfiles one per
# service.
# RUN su - postgres -c "createuser -s discourse"

# Install Ruby 2.0.0 (not bothering to use RVM)
RUN add-apt-repository ppa:brightbox/ruby-ng-experimental  && apt-get -qy update
RUN apt-get -qy install ruby2.0 ruby2.0-dev

RUN echo "gem: --no-ri --no-rdoc" > ~/.gemrc
RUN gem install bundler

# Add postmark support for sending email, and update Gemfile.lock
RUN echo "gem 'postmark-rails', '~> 0.5.2'" >> /discourse/Gemfile
RUN cd discourse && bundle install 

RUN cd discourse && bundle install --deployment --without test

RUN cd discourse/config && cp database.yml.production-sample database.yml && cp redis.yml.sample redis.yml && cp environments/production.rb.sample environments/production.rb

ENV RAILS_ENV production

# ./public will be a docker data-volume to be shared with nginx. Move
# the original public folder out of the way, for now.
RUN mv /discourse/public /discourse/public.oow

ADD	enter /
RUN	chmod +x /enter
WORKDIR   /discourse
ENTRYPOINT ["/enter"]
