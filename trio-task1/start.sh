#!/bin/bash

# Delete running containers

docker rm -f $(docker ps -qa)

# Create network

docker network create my-network

# Build flask app image
#cd flask-app/
docker build -t flask:latest flask-app #//flask-app points to the folder, no need for "."
#cd ..

# Build MySQL Database image
#cd db/
docker build -t mysql:latest db #//db points to the folder, no need for "."
#cd ..

# Run flask-app container on network
docker run -d \
--network my-network \
--name flask-app \
flask:latest

# Run MySQL container on network
docker run -d \
--network my-network \
--name mysql \
mysql:latest

# Run MySQL container on network with volume
# docker volume create mysql-volume

# docker run \
# --mount type=volume,source=mysql-volume,target=/var/lib/docker/volumes/mysql-volume/_data mysql:latest \


# Run nginx container on network
#cd nginx/
docker run -d \
--network my-network \
--name nginx \
--mount type=bind,source=$(pwd)/nginx/nginx.conf,target=/etc/nginx/nginx.conf \
-p 80:80 \
nginx:alpine
#cd ..