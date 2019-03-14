#!/bin/bash

#
# 搭建nginx-proxy用来代理，以及自动申请证书
#

# 创建一个专用网络webproxy，这个网络名称，在step3中要用到
docker network create webproxy

# 下载最新的nginx.tmpl文件
curl https://raw.githubusercontent.com/jwilder/nginx-proxy/master/nginx.tmpl > ./nginx.tmpl

# 启动nginx代理及其它服务
docker-compose up -d

# 如果你有自定义的一些nginx配置，可以放在conf.d目录下，如果没有可以注释下面的命令
# 我这里给的是一些比较基础的配置，基本大家都需要用上的
cp -r ./conf.d/*.conf /var/lib/docker/volumes/step2-install-nginx-proxy_conf/_data/

docker container restart nginx-proxy