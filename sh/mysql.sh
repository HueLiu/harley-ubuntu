#!/bin/bash
systemctl disable mysql
service mysql start
echo "启动MYSQL成功"
echo `mysql -uroot -e "CREATE USER 'root'@'%' IDENTIFIED BY '123456';"`
echo "创建用户成功"
echo `mysql -uroot -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;"`
echo "修改权限成功"
service mysql stop
echo "停止MYSQL成功"
