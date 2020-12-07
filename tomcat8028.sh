#!/bin/bash
docker run --name tomcat8028 \
	-d \
	-p 8028:8080 \
	-v /home/tomcat8028/webapps:/usr/local/tomcat/webapps \
	-v /home/tomcat8028/logs:/usr/local/tomcat/logs \
	-v /etc/localtime:/etc/localtime \
	--restart always \
	tomcat
