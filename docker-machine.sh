#!/bin/bash

docker-machine env && docker-machine env opsworks
eval $(docker-machine env opsworks)
#remove all running containers
docker ps | sed -e s/\ // | awk '{print $1}' &> /var/log/docker-machine
docker run -d -p 80:80 najar/nginx &> /var/log/docker-machine

