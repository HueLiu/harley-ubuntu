#!/bin/bash
systemctl disable postgresql
service postgresql start
echo "启动PostgreSQL成功"
echo `su postgres -c "psql -c 'ALTER USER postgres WITH PASSWORD '\'postgres\''';"`
echo "修改postgres用户密码成功"
service postgresql stop
echo "停止PostgreSQL成功"
