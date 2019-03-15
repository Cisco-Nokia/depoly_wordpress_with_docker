#!/bin/bash

#
# 该脚本适用于CentOS7安装docker及docker-compose
#

source ./.env

echo "###########卸载历史版本（如果有的话）###########"
yum remove -y docker docker-common docker-selinux docker-engine

echo "###########安装docker所需依赖###########"
yum install -y yum-utils device-mapper-persistent-data lvm2

if [ ! -z ${DOCKER_YUM_REPO+X} ]; then
	echo "###########增加一个国内的yum仓库，加速docker组件下载###########"
    yum-config-manager \
    --add-repo \
    ${DOCKER_YUM_REPO}
	yum makecache fast
else
    yum-config-manager \
     --add-repo \
     https://download.docker.com/linux/centos/docker-ce.repo
fi
	
echo "###########安装docker主程序###########"
yum install -y docker-ce

if [ ! -z ${DOCKER_IMAGE_REPO+X} ]; then
	echo "###########设置docker拉取镜像时，使用国内加速源###########"
	mkdir -p /etc/docker
	cat >> /etc/docker/daemon.json << EOF
	{
	  "registry-mirrors": ["${DOCKER_IMAGE_REPO}"]
	}
EOF
fi

echo "###########添加随机启动###########"
systemctl enable docker

echo "###########开启docker服务###########"
systemctl start docker

echo "###########查看Registry Mirrors信息是否为上面配置的加速源###########"
docker info

echo "####如果以上输出正常，则表示docker正确安装。#####"

echo "####开始安装docker-compose####"
curl -L https://github.com/docker/compose/releases/download/1.23.2/docker-compose-`uname -s`-`uname -m` -o /usr/bin/docker-compose
chmod +x /usr/bin/docker-compose
# 添加命令补全功能
yum -y install bash-completion
curl -L https://raw.githubusercontent.com/docker/compose/1.23.2/contrib/completion/bash/docker-compose -o /etc/bash_completion.d/docker-compose
source /etc/bash_completion.d/docker-compose

echo "####提前下载后续要用到的镜像####"
docker image pull mysql:5.7
docker image pull wordpress:latest
docker image pull nginx
docker image pull jrcs/letsencrypt-nginx-proxy-companion
docker image pull jwilder/docker-gen
