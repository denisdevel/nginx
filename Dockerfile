#Dockerfile

FROM nginx

MAINTAINER Najar <denis.devel@gmail.com>

EXPOSE 80

RUN apt-get update && apt-get install nginx



