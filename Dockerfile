#Dockerfile

FROM debian

MAINTAINER Najar <denis.devel@gmail.com>

ENV LUAJIT_INC "/root/luajit-2.0/src"
ENV LUAJIT_LIB "/root/luajit-2.0/src"


RUN apt-get update && apt-get install -y git make gcc wget nano libpcre3-dev libzlcore0.1 && cd /root && \
    wget http://nginx.org/download/nginx-1.13.11.tar.gz && git clone http://luajit.org/git/luajit-2.0.git && \
    git clone https://github.com/simplresty/ngx_devel_kit && git clone https://github.com/openresty/lua-nginx-module && \
    cd /root && wget http://zlib.net/zlib-1.2.11.tar.gz && tar -zxf zlib-1.2.11.tar.gz && cd zlib*/ && ./configure && make && make install && \
    cd /root/luajit-2.0/ && make && make install && \ 
    cd /root && tar xvf nginx*.tar.gz && cd /root/nginx*/ && ./configure --with-ld-opt="-Wl,-rpath,/root/luajit-2.0/src" --add-module=/root/ngx_devel_kit/ --add-module=/root/lua-nginx-module/ && \
    make && make install && ln -s /usr/local/lib/libluajit-5.1.so.2 /usr/lib/

COPY ./nginx.conf /usr/local/nginx/conf

ADD ./index.html /usr/local/nginx/html

RUN  /usr/local/nginx/sbin/nginx -t && rm -rf /root/nginx* && rm -rf /root/zlib* && rm -rf /root/*.tar.gz && rm -rf /var/lib/apt/lists/*

EXPOSE 80

CMD /usr/local/nginx/sbin/nginx -g 'daemon off;'


