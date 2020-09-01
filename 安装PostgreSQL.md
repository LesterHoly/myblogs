---
title: Ubuntu 18.04 安装PostgreSQL9.6
date: 2020-02-01 09:54:07
updated: 2020-02-01 09:54:07
tags: PostgreSQL
categories: Ubuntu
keywords:
description:
top_img:
comments:
cover: https://image.holynlp.com/2020-09-01-1_PY24xlr4TpOkXW04HUoqrQ.jpeg
toc:
toc_number:
auto_open:
copyright:
copyright_author:
copyright_author_href:
copyright_url:
copyright_info:
mathjax:
aplayer:
highlight_shrink:
---



PostgreSQL，通常简称为Postgres，是一种开源的通用对象 - 关系数据库管理系统。 PostgreSQL具有许多高级功能，如在线备份，即时恢复，嵌套事务，SQL和JSON查询，多版本并发控制（MVCC），异步复制等。

### 安装PostgreSQL
```shell
sudo add-apt-repository "deb http://apt.postgresql.org/pub/repos/apt/ bionic-pgdg main"
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt update
```

```shell
sudo apt-get install postgresql-9.6
```

安装完成后，PostgreSQL服务将自动启动。 用psql实用程序连接到PostgreSQL数据库服务器验证安装

```shell
sudo -u postgres psql -c "SELECT version();"
```

### 修改Postgres默认密码

安装PostgreSQL时会自动创建postgres用户。 该用户是PostgreSQL实例的超级用户，它相当于MySQL root用户。可以使用sudo命令访问PostgreSQL提示符而无需切换用户。

```shell
sudo -u postgres psql
# 更改密码
postgres=# \password postgres
Enter new password:
Enter it again:
```

### 新建用户，并为之创建密码和数据库

```SQL
postgres=# CREATE USER lester WITH PASSWORD '123456';
CREATE ROLE
postgres=# CREATE DATABASE lesterdb OWNER lester;
CREATE DATABASE
postgres=# GRANT all privileges on database lesterdb to lester;
GRANT
postgres=# \q
```

### 启用对PostgreSQL服务器的远程访问

默认情况下，PostgreSQL服务器仅侦听本地接口127.0.0.1。 要启用对PostgreSQL服务器的远程访问，打开配置文件postgresql.conf并在CONNECTIONS AND AUTHENTICATION部分添加listen_addresses ='*'，并将默认端口5432改为自己想要的。

```shell
sudo vim /etc/postgresql/9.6/main/postgresql.conf
```


```shell
listen_addresses = '*'
#listen_addresses = 'localhost'         # what IP address(es) to listen on;
                                        # comma-separated list of addresses;
                                        # defaults to 'localhost'; use '*' for all
                                        # (change requires restart)
port = 15432
```

开启远程连接

```shell
sudo vim /etc/postgresql/9.6/main/pg_hba.conf
```

```shell
# 在文件末尾添加
host    all             all             0.0.0.0/0               md5
```

```shell
# 最后重启数据库服务
sudo service postgresql restart
```

