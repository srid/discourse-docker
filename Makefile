all:
	sudo docker build -t srid/discourse discourse
	sudo docker build -t "srid/postgresql:9.1" postgresql
	sudo docker build -t "srid/redis:2.6" redis
	sudo docker build -t "srid/nginx:1.3" nginx
	sudo docker images | grep srid
