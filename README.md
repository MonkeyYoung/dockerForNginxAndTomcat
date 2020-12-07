# dockerForNginxAndTomcat
容器化部署nginx、tomcat后实现负载均衡

## 1.下载容器
    $docker pull nginx
    $docker pull tomcat

## 2.配置tomcat（8028同理，修改端口号即可）
    #!/bin/bash
    docker run --name tomcat8027 \
        -d \
        -p 8027:8080 \
        -v /home/tomcat8027/webapps:/usr/local/tomcat/webapps \
        -v /home/tomcat8027/logs:/usr/local/tomcat/logs \
        -v /etc/localtime:/etc/localtime \
        --restart always \
        tomcat

## 3.配置nginx
    #!/bin/bash
    docker run --name nginx-test \
        -d \
        -p 80:80 \
        -v /home/nginx/www:/usr/share/nginx/html \
        -v /home/nginx/logs:/var/log/nginx \
        -v /home/nginx/conf/nginx.conf:/etc/nginx/nginx.conf \ #docker cp 将容器内的nginx.conf 复制到容器外，使得配置持久化，再挂载。
        -v /home/nginx/conf/conf.d:/etc/nginx/conf.d \ #docker cp 将容器内的conf.d文件夹复制到容器外，使得配置持久化，再挂载。
        -v /etc/localtime:/etc/localtime \
        --restart always \
        nginx
## 4.配置conf.d/default.conf

    upstream cd {
        server 10.10.16.218:8027 weight=1;
        server 10.10.16.218:8028 weight=1;
    }
    server {
        listen       80;
        listen  [::]:80;
        server_name  10.10.16.218;

        #charset koi8-r;
        #access_log  /var/log/nginx/host.access.log  main;

        location / {
            #root   /usr/share/nginx/html;
            #index  index.html ;
            proxy_pass http://cd;
        }
    ...
## 5.执行脚本
    $sh tomcat8027.sh
    $sh tomcat8028.sh
    $sh nginx.sh
## 6.查看结果
    $docker ps 
    $curl 10.10.16.218 #多次执行，访问不同页面
