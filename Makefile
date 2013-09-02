all:
	sudo docker build -t srid/discourse discourse
	sudo docker build -t "srid/postgresql:9.1" postgresql
	sudo docker build -t "srid/redis:2.6" redis
	sudo docker build -t "srid/discourse-nginx:1.3" nginx
	sudo docker images | grep srid

discourse-image:
	sudo docker build -t srid/discourse discourse
	sudo docker images | grep srid/discourse

push:
	echo

ps:
	sudo docker ps 

supervisor:
	sudo `which supervisord` -n -c etc/supervisord.conf

info:
	bin/nginx-info
