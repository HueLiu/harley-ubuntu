FROM ubuntu

RUN apt-get update && apt-get upgrade -y

# 安装vim
RUN apt-get install vim python-is-python3 supervisor -y

# 安装JDK8
RUN apt-get install openjdk-8-jdk -y

# 安装MySQL
RUN apt-get install mysql-server -y
COPY ./config/mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf
RUN chown -R mysql:mysql /var/lib/mysql /var/run/mysqld /var/log/

# 安装SQLite3
RUN apt-get install sqlite3 -y

# 安装Postgresql
RUN DEBIAN_FRONTEND=noninteractive apt-get install postgresql -y
COPY ./config/postgresql.conf /etc/postgresql/14/main/postgresql.conf
COPY ./config/pg_hba.conf /etc/postgresql/14/main/pg_hba.conf

# 安装Redis
RUN apt-get install redis -y
COPY ./config/redis.conf /etc/redis/redis.conf

# 安装MongoDB
RUN apt-get install wget libcurl4 libgssapi-krb5-2 libldap-2.5-0 libwrap0 libsasl2-2 libsasl2-modules libsasl2-modules-gssapi-mit snmp openssl liblzma5 -y
RUN wget -P /opt https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-ubuntu2204-6.0.6.tgz \
    && tar -xzvf /opt/mongodb-linux-x86_64-ubuntu2204-6.0.6.tgz -C /opt/ \
    && mv /opt/mongodb-linux-x86_64-ubuntu2204-6.0.6 /opt/mongo \
    && rm -rf /opt/mongodb-linux-x86_64-ubuntu2204-6.0.6.tgz
RUN mkdir /opt/mongo/conf/ && mkdir /opt/mongo/logs/ && mkdir /opt/mongo/data/
RUN chmod -R 777 /opt/mongo/
COPY ./config/mongo.conf /opt/mongo/conf/mongo.conf


# RUN rm -rf /var/lib/apt/lists/*

# 拷贝脚本
COPY ./supervisor/ /etc/supervisor/conf.d/
RUN mkdir /home/sh/
RUN mkdir /home/logs/
COPY ./sh /home/sh/
RUN chmod -R 777 /home/

# Define default command.
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]