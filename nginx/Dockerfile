# -*- sh -*-

FROM ubuntu:12.04

# prevent apt from starting nginx right after the installation
RUN	echo "#!/bin/sh\nexit 101" > /usr/sbin/policy-rc.d; chmod +x /usr/sbin/policy-rc.d

RUN echo "deb http://nginx.org/packages/ubuntu/ precise nginx" >> /etc/apt/sources.list
RUN echo "deb-src http://nginx.org/packages/ubuntu/ precise nginx" >> /etc/apt/sources.list
RUN apt-get -qy install curl
RUN curl http://nginx.org/keys/nginx_signing.key | apt-key add -
RUN apt-get update
RUN apt-get -qy install nginx

RUN echo "daemon off;" >> /etc/nginx/nginx.conf

ADD start /
RUN chmod +x /start

ADD discourse.conf /etc/nginx/conf.d/
RUN mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf.disabled

EXPOSE 80
CMD /start

