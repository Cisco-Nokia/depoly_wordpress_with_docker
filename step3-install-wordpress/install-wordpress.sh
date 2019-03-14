#!/bin/bash

#
# 本脚本适用于CentOS 7使用docker安装wordpress
#

source ./.env

# 启动wordpress
docker-compose up -d
