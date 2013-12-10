all:
	echo

build:
	sudo docker build -t srid/discourse discourse
	sudo docker build -rm -t "srid/postgresql:9.1" postgresql
	sudo docker build -rm -t "srid/redis:2.6" redis
	sudo docker build -rm -t "srid/discourse-nginx:1.3" nginx
	sudo docker images | grep srid

build-discourse-only:
	sudo docker build -t srid/discourse discourse
	sudo docker images | grep srid/discourse

pull:
	sudo docker pull srid/discourse-nginx
	sudo docker pull srid/redis
	sudo docker pull srid/postgresql
	sudo docker pull srid/discourse

push:
	sudo docker push srid/discourse-nginx
	sudo docker push srid/redis
	sudo docker push srid/postgresql
	sudo docker push srid/discourse

ps:
	sudo docker ps 

supervisor:
	sudo `which supervisord` -n -c etc/supervisord.conf

info:
	bin/nginx-info
