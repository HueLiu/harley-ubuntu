#!/bin/bash

# 执行 MySQL 初始化脚本
if [ -f "/home/sh/mysql.sh" ];then
  echo "Start initializing MySQL."
  /home/sh/mysql.sh
  rm -rf /home/sh/mysql.sh
  echo "End initializing MySQL."
else
  echo "MySQL settings has been initialized."
fi

supervisorctl start mysql


# 执行 PostgreSQL 初始化脚本
if [ -f "/home/sh/postgresql.sh" ];then
  echo "Start initializing PostgreSQL."
  /home/sh/postgresql.sh
  rm -rf /home/sh/postgresql.sh
  echo "End initializing PostgreSQL."
else
  echo "PostgreSQL settings has been initialized."
fi

supervisorctl start postgresql

/bin/bash