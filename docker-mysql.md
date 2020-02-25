### 利用docker配置MySQL数据库

>
>
>系统：Ubuntu18.04
>
>docker 版本：Docker version 19.03.6
>
>MySQL版本：5.7

#### 1. 下拉MySQL容器镜像

```shell
docker pull mysql:5.7.29
```

#### 2. 创建`my.cnf`配置文件和`data`数据文件夹

```shell
mkdir -p ~/.docker_data/mysql/config; mkdir -p ~/.docker_data/mysql/data
```

创建两个文件夹：`~/.docker_data/mysql/config` 和 `~/.docker_data/mysql/data` 保持数据持久化。config文件夹下的`my.cnf`用于存储配置，`data`文件夹用于存储数据。

```shell
vim /home/ubuntu/.docker_data/mysql/config/my.cnf


my.cnf
**************************************************
[mysqld]
user=mysql
character-set-server=utf8
default_authentication_plugin=mysql_native_password
[client]
default-character-set=utf8
[mysql]
default-character-set=utf8
```

#### 3. 运行数据库

```shell
docker run -d \
--restart always \
-p 13306:3306 \
--privileged=true \
-v /home/ubuntu/.docker_data/mysql/config/my.cnf:/etc/mysql/my.cnf \
-v /home/ubuntu/.docker_data/mysql/data:/var/lib/mysql \
-e MYSQL_ROOT_PASSWORD=root123 \
--name mysql5.7 \
mysql:5.7.29
```

参数说明：

* --privileged=true：容器内的root拥有真正root权限，否则容器内root只是外部普通用户权限

* -v /home/ubuntu/.docker_data/mysql/config/my.cnf:/etc/mysql/my.cnf：映射配置文件

* -v /home/ubuntu/.docker_data/mysql/data:/var/lib/mysql：映射数据目录

#### 4. 进入MySQL容器

```shell
docker exec -it mysql5.7 /bin/bash
```

#### 5. 在容器内连接数据库

```shell
root@a55b06f6b1ae:/# mysql -uroot -p
```

#### 6. 创建新用户

```sql
mysql> CREATE USER 'test'@'%' IDENTIFIED BY 'root123456' PASSWORD EXPIRE NEVER;
mysql> GRANT ALL PRIVILEGES ON *.* TO 'test'@'%' IDENTIFIED BY 'root123456' WITH GRANT OPTION;
mysql> FLUSH  PRIVILEGES;
mysql> quit;
```

#### 7. 远程测试连接（N）

![测试远程连接](https://image.holynlp.com/2020-02-24-141910.png)