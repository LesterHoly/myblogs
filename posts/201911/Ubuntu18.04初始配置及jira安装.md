title: Ubuntu 18.04 初始配置及jira安装
date: '2019-11-25 20:49:27'
updated: '2019-11-25 20:53:06'
tags: [ubuntu18.04, jira]
permalink: /articles/2019/11/25/1574686167624.html
---
# Ubuntu 18.04 初始配置及jira安装

### 安装语言包

```text
sudo apt install language-pack-zh-hant language-pack-zh-hans -y
```

### 配置时区

```text
sudo dpkg-reconfigure tzdata
```

### 安装常用软件

```text
sudo apt install git wget curl unzip vim -y
```

### 配置登陆

修改配置 `sudo vim /etc/ssh/sshd_config` 文件，禁用密码登录，以及尽可能避免使用 **root** 用户直接登录系统。

```text
PermitRootLogin no
PasswordAuthentication no
```

重启ssh服务

```text
sudo service ssh restart
```

### 安装java8

```java
sudo apt install openjdk-8-jdk
```

### 安装mysql(5.7版本)

```shell
# 安装mysql服务
sudo apt-get install mysql-server
# 安装客户端
sudo apt install mysql-client
# 安装依赖
sudo apt install libmysqlclient-dev
# 检查状态
sudo netstat -tap | grep mysql
```

设置mysql的root用户密码

> mysql5.7安装完成后普通用户不能进mysql，原因：root的plugin被修改成了auth_socket，用密码登陆的plugin应该是mysql_native_password，直接用root权限登录就不用密码,修改root密码和登录验证方式： 

```sql
sudo su  # 切换到root用户
mysql
mysql> select user, plugin from mysql.user;
mysql> update mysql.user set  authentication_string=PASSWORD('123456'),plugin='mysql_native_password' where user='root';
mysql> flush privileges;
mysql> exit
exit  # 退出root用户
```
重启mysql服务
```shell
sudo /etc/init.d/mysql restart
```

开启远程访问方法

```shell
sudo vim /etc/mysql/mysql.conf.d/mysqld.cnf  # 修改配置文件
# bind-address = 127.0.0.1 注释掉
```

执行授权命令
```sql
mysql -u root -p123456
mysql> grant all on *.* to root@'%' identified by '123456' with grant option;
```
重启mysql服务
```shell
sudo /etc/init.d/mysql restart
```

### 创建Jira数据库

进入mysql

```shell
mysql -uroot -p123456
```

创建jira数据库

```sql
CREATE DATABASE `jira201911` /*!40100 DEFAULT CHARACTER SET utf8*/;
```

加远程访问权限

```sql
GRANT ALL ON jira201911.* TO root@'%' IDENTIFIED BY '123456';
```

### 安装Jira

官网下载，版本为atlassian-jira-software-8.2.2-x64.bin包含中文语言安装包

```shell
sudo wget https://downloads.atlassian.com/software/jira/downloads/atlassian-jira-software-8.2.2-x64.bin
```

设置可执行权限

```shell
sudo chmod +x atlassian-jira-software-8.2.2-x64.bin
```

安装
```shell
sudo ./atlassian-jira-software-8.2.2-x64.bin

Unpacking JRE ...
Starting Installer ...
Fontconfig warning: ignoring UTF-8: not a valid region tag

This will install JIRA Software 8.2.2 on your computer.
OK [o, Enter], Cancel [c]
o
Click Next to continue, or Cancel to exit Setup.

Choose the appropriate installation or upgrade option.
Please choose one of the following:
Express Install (use default settings) [1], Custom Install (recommended for advanced users) [2, Enter], Upgrade an existing JIRA installation [3]


Select the folder where you would like JIRA Software to be installed.
Where should JIRA Software be installed?
[/opt/atlassian/jira]


Default location for JIRA Software data
[/var/atlassian/application-data/jira]


Configure which ports JIRA Software will use.
JIRA requires two TCP ports that are not being used by any other
applications on this machine. The HTTP port is where you will access JIRA
through your browser. The Control port is used to startup and shutdown JIRA.
Use default ports (HTTP: 8080, Control: 8005) - Recommended [1, Enter], Set custom value for HTTP and Control ports [2]
2
HTTP Port Number
[8080]
8088
Control Port Number
[8005]
8089

JIRA can be run in the background.
You may choose to run JIRA as a service, which means it will start
automatically whenever the computer restarts.
Install JIRA as Service?
Yes [y, Enter], No [n]
y

Details on where JIRA Software will be installed and the settings that will be used.
Installation Directory: /opt/atlassian/jira
Home Directory: /var/atlassian/application-data/jira
HTTP Port: 8088
RMI Port: 8089
Install as service: Yes
Install [i, Enter], Exit [e]
i

Extracting files ...

Please wait a few moments while JIRA Software is configured.

Installation of JIRA Software 8.2.2 is complete
Start JIRA Software 8.2.2 now?
Yes [y, Enter], No [n]
y

Please wait a few moments while JIRA Software starts up.
Launching JIRA Software ...

Installation of JIRA Software 8.2.2 is complete
Your installation of JIRA Software 8.2.2 is now ready and can be accessed
via your browser.
JIRA Software 8.2.2 can be accessed at http://localhost:8088
Finishing installation ...
```

### jira破解包

[破解包下载地址](https://drive.google.com/file/d/1r5nvoX0Ff_8xcksqlajT5XJVEzUu0Ya7/view?usp=sharing)

> 解压后里面有两个文件：
>
> 其中atlassian-extras-3.2.jar是用来替换原来的atlassian-extras-3.1.2.jar文件，用作破解jira系统的。
>
> 而mysql-connector-java-5.1.39-bin.jar是用来连接mysql数据库的驱动软件包（没有该文件在下面安装jira会报错）。
>
> 或者使用mysql-connector-java-5.1.47-bin.jar用来连接mysql数据库的驱动软件包,该文件为mysql5.7的驱动。
>
> 把破解包里面的atlassian-extras-3.2.jar和mysql-connector-java-5.1.47-bin.jar两个文件复制到/opt/atlassian/jira/atlassian-jira/WEB-INF/lib/目录下。

### 启动jira

进入jira安装的bin目录，启动jira

```shell
cd /opt/atlassian/jira/bin
sudo sh startup.sh
```

通过浏览器打开网址：http://<your ip>:8088/secure/Dashboard.jspa即可访问jira

### 卸载jira

```shell
rm -rf /opt/atlassian/jira/
rm -rf /var/atlassian/application-data/jira
```

### Reference

[Ubuntu16.04 安装Jira8.2.2](https://www.cnblogs.com/ranxf/p/11043802.html)

[Jira 安装配置](https://networm.me/2019/02/03/jira-install/)

[Ubuntu18.04-默认安装mysql5.7](https://blog.csdn.net/feiyanaffection/article/details/81949484)

[How To Install Java with `apt` on Ubuntu 18.04](https://www.digitalocean.com/community/tutorials/how-to-install-java-with-apt-on-ubuntu-18-04)



### 国际惯例
> 本项目只做个人学习研究之用，不得用于商业用途！
> 商业使用请向[Atlassian](https://www.atlassian.com/)购买正版，谢谢合作！


