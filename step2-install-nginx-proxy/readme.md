## 简介
参考：https://github.com/JrCs/docker-letsencrypt-nginx-proxy-companion即可。

## 使用方式
直接运行`install-nginx-proxy.sh`脚本即可。

## 备注
- 记得脚本中创建的自定义docker network网络名称为**webproxy**，后面step3中要用到。
- 如果对于nginx反向代理服务，还有自定义的配置需求，可以把配置放在conf.d目录下，并重启`nginx-proxy`容器。