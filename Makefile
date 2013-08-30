all:
	sudo docker build -t srid/discourse - < discourse.Dockerfile
	sudo docker build -t srid/postgresql:9.1 postgresql
	sudo docker build -t srid/redis:2.6 redis
	sudo docker images | grep srid
