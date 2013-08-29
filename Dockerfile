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
RUN su - postgres -c "createuser -s discourse"

# XXX: we are struck here, as docker won't run installed services, for
# good reason. need to look into having multiple Dockerfiles one per
# service.