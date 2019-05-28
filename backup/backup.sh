#!/bin/bash

# 本脚本用于备份wordpress相关数据
# 只用停止wordpress容器和mysql容器即可，剩下的三个容器所使用的数据
# 都是根据容器信息来即时生成的，无需备份

# 手动写出你从github上下载仓库时，保存在本地的绝对路径
REPO_PATH="/root/depoly_wordpress_with_docker"

DATA_PATH="/var/lib/docker/volumes"
DATE=`date "+%Y%m%d"`

# 指定你要备份tar包存放的目录
BACKUP_DIR="/var/wp_back"
# 如果备份目录不存在，则创建
if [ ! -d $BACKUP_DIR ]; then
    mkdir -p $BACKUP_DIR
fi


# 这里务必切换到docker-compose.yml所在的目录，不然无法读取到相关变量
cd $REPO_PATH/step3-install-wordpress/
#docker-compose -f $REPO_PATH/step3-install-wordpress/docker-compose.yml config

# 停止容器
docker-compose -f $REPO_PATH/step3-install-wordpress/docker-compose.yml down

# 打包数据库文件
tar -cpzf $BACKUP_DIR/wordpress_db_data-${DATE}.tar.gz ${DATA_PATH}/step3-install-wordpress_db_data

# 打包wordpress文件
tar -cpzf $BACKUP_DIR/wordpress_wp_data-${DATE}.tar.gz ${DATA_PATH}/step3-install-wordpress_wp_data

# 重新启动wordpress和mysql镜像
docker-compose -f $REPO_PATH/step3-install-wordpress/docker-compose.yml up -d

# 只保留最近5天的备份
find $BACKUP_DIR -mtime +5 -name "*.tar.gz" -exec rm -rf {} \;