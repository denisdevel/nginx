#Dockerfile

FROM nginx

MAINTAINER Najar <denis.devel@gmail.com>

EXPOSE 80

RUN apt-get update && apt-get install nginx  && rm -rf /var/lib/apt/lists/*

COPY ./default.conf /etc/nginx/conf.d/

ADD ./index.html /usr/share/nginx/html/

CMD nginx -g 'daemon off;'


