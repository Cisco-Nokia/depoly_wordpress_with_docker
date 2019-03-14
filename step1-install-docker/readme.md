## 简介
用于在CentOS 7上安装docker-ce以及docker-compose

请先编辑.env文件，配置一些参数。

之后运行install-docker.sh脚本即可。

---
## 备注
- 如果你的服务器在国内，最大的问题还是网络，如果你们有更好的加速源，可以修改
.env配置文件里面的配置。
- 下载docker-compose文件的时候，可以到[Docker的github](https://github.com/docker/compose/releases)
上，下载最新的版本，对应的命令补全功能也下载一样的版本。