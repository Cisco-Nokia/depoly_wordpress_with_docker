# 快速部署带有SSL证书的wordpress
使用这个仓库，你可以快速使用docker部署一个带`Let's Encrypt`SSL证书的wordpress博客，并且能够自动续签证书。

## 工作流程简介
1. 在CentOS 7上安装docker及docker-compose。
2. 使用docker，运行`nginx`，`jwilder/docker-gen`，`jrcs/letsencrypt-nginx-proxy-companion`这三个镜像。
- 镜像`nginx`，作为实际的代理服务。
- 镜像`jwilder/docker-gen`，用来获取nginx要代理的容器的网络信息，主要是IP端口等，传递给nginx服务，在后面的wordpress容器启动和停止时 `docker-gen`还会生成nginx反向代理配置并且重新加载 nginx。
- 镜像`jrcs/letsencrypt-nginx-proxy-companion`，用来配合nginx进行证书的申请、续签等。
3. 使用docker，运行`mysql:5.7`，`wordpress:latest`这两个镜像。这两个组成实际的网站，存储你的个人相关数据。

## 使用方法

配置各个目录下的.env文件（如果有的话），然后运行以install开头的脚本即可。可以自己按步骤执行，并进行相关测试。
> 备注：你需要提前配置好你的域名解析到你的服务器IP，并保证80和443端口网络畅通，否则后面自动申请证书会无法通过。

---
参考：

[nginx-proxy](https://github.com/jwilder/nginx-proxy)

[docker-compose-letsencrypt-nginx-proxy-companion](https://github.com/evertramos/docker-compose-letsencrypt-nginx-proxy-companion)