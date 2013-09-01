# -*- sh -*-

FROM ubuntu:12.04

RUN apt-get -qy install python-software-properties
RUN apt-add-repository -y ppa:rwky/redis
RUN apt-get -qy update
RUN apt-get -qy install redis-server

EXPOSE 6379
CMD /usr/bin/redis-server
