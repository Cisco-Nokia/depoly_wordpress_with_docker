#!/bin/bash


# 运行一个httpd容器，进行测试
# 该脚本使用方式为："./test_ssl.sh www.domain.com"
# www.domain.com是你的域名，必须已经配置好DNS解析，以及保证主机网络80和443端口通畅
# 脚本启动完成后，稍微等待一段时间，就可使用https访问你的网站了，出现"It works!"代表OK
# 运行test_stop.sh即可关闭测试

NAME=test-web

# Set up your DOMAIN
if [ $# -eq 0 ]; then
    echo "请输入你要用于测试的域名"
    echo "./test_start_ssl.sh $1"
    exit 1
else
    DOMAIN=$1
fi

# Testing your proxy
docker run -d -e VIRTUAL_HOST=$DOMAIN -e LETSENCRYPT_HOST=$DOMAIN --network=webproxy --name $NAME httpd:alpine

exit 0
