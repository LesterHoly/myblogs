### 1. 什么是 nginx [nginx wiki](https://www.nginx.com/resources/wiki/)

NGINX is a free, open-source, high-performance HTTP server and reverse proxy, as well as an IMAP/POP3 proxy server. NGINX is known for its high performance, stability, rich feature set, simple configuration, and low resource consumption.

### 2. 反向代理

#### 正向代理

> 在客户端（浏览器）配置代理服务器，通过代理服务器进行互联网访问

![img](http://image.holynlp.com/2020-01-03-073954.png)

#### 反向代理

> 反向代理对于客户端是无感知的，因为客户端不需要做任何配置就可以访问，我们只需要将请求发送到反向代理服务器，由反向代理服务器去选择目标服务器获取数据后，在返回给客户端，此时反向代理服务器和目标服务器对外就是一个服务器，暴露的是代理服务器地址，隐藏了真实服务器 ip 地址。

![img](http://image.holynlp.com/2020-01-03-075534.png)

### 3. 负载均衡

> 在并发数大的时候，单个服务器无法及时产生响应，增加服务器的数量，将请求分发到各个服务器上，将原先请求集中到单个服务器上的情况改为将请求分发到多个服务器上，将负载分发到不同的服务器，也就是我们所说的负载均衡。

![img](http://image.holynlp.com/2020-01-03-080704.png)

### 4. 动静分离

> 为了加快网站的解析速度，可以将动态页面和静态页面由不同的服务器来解析，加快解析速度，降低原来单个服务器的压力。

![img](http://image.holynlp.com/2020-01-03-081558.png)

### nginx 在 Linux 系统中安装

#### 1. 查看 Linux 版本

- 查看内核版本

```shell
// 方法一
ubuntu@ip-172-31-44-14:~$ cat /proc/version
Linux version 4.15.0-1051-aws (buildd@lgw01-amd64-005) (gcc version 7.4.0 (Ubuntu 7.4.0-1ubuntu1~18.04.1)) #53-Ubuntu SMP Wed Sep 18 13:35:53 UTC 2019

// 方法二
ubuntu@ip-172-31-44-14:~$ uname -a
Linux ip-172-31-44-14 4.15.0-1051-aws #53-Ubuntu SMP Wed Sep 18 13:35:53 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux
```

- 查看系统版本

```shell
// 方法一
ubuntu@ip-172-31-44-14:~$ lsb_release -a
No LSB modules are available.
Distributor ID:	Ubuntu
Description:	Ubuntu 18.04.3 LTS
Release:	18.04
Codename:	bionic

// 方法二
ubuntu@ip-172-31-44-14:~$ cat /etc/issue
Ubuntu 18.04.3 LTS \n \l
```

#### 2. 安装 nginx

```shell
sudo apt update  
sudo apt install nginx -y
```

#### 3. 管理 nginx

```shell
sudo systemctl status nginx  
sudo systemctl start nginx
sudo systemctl stop nginx
sudo systemctl restart nginx
sudo systemctl reload nginx
sudo systemctl enable nginx
sudo systemctl disable nginx
```

#### 4. nginx 相关命令

```shell
netstat -ntpl | grep 80  #查看进程信息
ps aux | grep ntinx
sudo nginx  #启动
sudo nginx -s stop  #停止
sudo nginx -s reload  #重加载
sudo nginx -c /etc/nginx/nginx.conf  #使用指定的配置文件启动
sudo nginx -t # 测试配置文件是否有错误
sudo nginx -v  #查看版本信息
```

#### 5. nginx 的配置文件

```shell
/etc/nginx/nginx.conf
```

Nginx 配置文件分为三部分

- 全局块
  - 从配置文件开始到 events 块之间的内容，主要设置一些影响 nginx 服务器整体运行的配置指令
- events 块
  - events 块涉及的指令主要影响 nginx 服务器与用户的网络连接
- http 块
  - http 块包括 http 全局块和 server 块