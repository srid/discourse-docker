FROM ubuntu:12.04
MAINTAINER srid

RUN apt-get -qy update

RUN apt-get -qy install git 

# Get discourse stable tag
RUN git clone --depth 1 https://github.com/discourse/discourse.git
RUN cd discourse && git checkout v0.9.6.1
RUN rm -rf discourse/.git

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

RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get -qy update
RUN apt-get -qy install build-essential libssl-dev libyaml-dev git libtool libxslt-dev libxml2-dev libpq-dev gawk curl pngcrush python-software-properties

# redis
RUN apt-add-repository -y ppa:rwky/redis
RUN apt-get update
RUN apt-get -qy install redis-server

# postgresql
RUN apt-get -qy install postgresql-9.1 postgresql-contrib-9.1

# nginx
RUN apt-get remove '^nginx.*$'

RUN echo "deb http://nginx.org/packages/ubuntu/ precise nginx" >> /etc/apt/sources.list
RUN echo "deb-src http://nginx.org/packages/ubuntu/ precise nginx" >> /etc/apt/sources.list
RUN curl http://nginx.org/keys/nginx_signing.key | apt-key add -

RUN apt-get -qy update
RUN apt-get -qy install nginx


# Discourse setup
#

# Create discourse database
# XXX: we are struck here, as docker won't run installed services, for
# good reason. need to look into having multiple Dockerfiles one per
# service.
# RUN su - postgres -c "createuser -s discourse"

# Install Ruby 2.0.0 (not bothering to use RVM)
RUN add-apt-repository ppa:brightbox/ruby-ng-experimental 
RUN apt-get -qy update
RUN apt-get -qy install ruby2.0 ruby2.0-dev

RUN echo "gem: --no-ri --no-rdoc" > ~/.gemrc
RUN gem install bundler

RUN cd discourse && bundle install --deployment --without test

RUN cd discourse/config && cp database.yml.production-sample database.yml
RUN cd discourse/config && cp redis.yml.sample redis.yml
RUN cd discourse/config && cp environments/production.rb.sample environments/production.rb
RUN cd discourse/config && cp discourse.pill.sample discourse.pill
