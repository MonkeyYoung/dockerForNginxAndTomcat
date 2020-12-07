#!/bin/bash
docker run --name nginx-test \
	-d \
	-p 80:80 \
	-v /home/nginx/www:/usr/share/nginx/html \
	-v /home/nginx/logs:/var/log/nginx \
        -v /home/nginx/conf/nginx.conf:/etc/nginx/nginx.conf \
	-v /home/nginx/conf/conf.d:/etc/nginx/conf.d \
	-v /etc/localtime:/etc/localtime \
	--restart always \
	nginx
