#!/bin/bash
docker run --name tomcat8027 \
	-d \
	-p 8027:8080 \
	-v /home/tomcat8027/webapps:/usr/local/tomcat/webapps \
	-v /home/tomcat8027/logs:/usr/local/tomcat/logs \
	-v /etc/localtime:/etc/localtime \
	--restart always \
	tomcat
