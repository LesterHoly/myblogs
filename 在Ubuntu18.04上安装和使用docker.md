### 在Ubuntu 18.04上安装和使用docker

[百度百科-docker](https://baike.baidu.com/item/Docker/13344470?fr=aladdin)

Docker 是一个[开源](https://baike.baidu.com/item/开源/246339)的应用容器引擎，让开发者可以打包他们的应用以及依赖包到一个可移植的镜像中，然后发布到任何流行的 [Linux](https://baike.baidu.com/item/Linux)或Windows 机器上，也可以实现[虚拟化](https://baike.baidu.com/item/虚拟化/547949)。容器是完全使用[沙箱](https://baike.baidu.com/item/沙箱/393318)机制，相互之间不会有任何接口。

### Step1 安装 Docker

#### 1 . 更新包

```
sudo apt update
```
#### 2. 安装依赖

```
sudo apt install apt-transport-https ca-certificates curl software-properties-common
```
#### 3. 在系统中添加docker官方仓库的GPG key

```
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
```

#### 4. 在apt source里添加docker仓库

```
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
```

#### 5. 再次更新apt包列表

```
sudo apt update
```

#### 6. 确认docker是从Docker repo安装而不是默认的Ubuntu repo:

```
apt-cache policy docker-ce
```

输出如下:

```
docker-ce:
  Installed: (none)
  Candidate: 18.03.1~ce~3-0~ubuntu
  Version table:
     18.03.1~ce~3-0~ubuntu 500
        500 https://download.docker.com/linux/ubuntu bionic/stable amd64 Packages
```

#### 7. 最后安装docker-ce

```
sudo apt install docker-ce
```

#### 8. 查看安装完之后的dokcer信息

```
sudo systemctl status docker
```

### Step2 将用户加入docker组实现不加sudo执行docker命令

#### 1. 查看/etc/group,确定是否存在docker组

```
cat /etc/group | grep docker
```

安装Docker后,docker组已经创建好了,上面的命令输出如下：
```
docker:x:999:
```

#### 2. 将当前用户添加到 docker 组

```
sudo gpasswd -a ${USER} docker
```

#### 3. 重新登录或者用以下命令切换到docker组

```
newgrp - docker
```

#### 4. 重启docker服务

```
sudo service docker restart
```

#### 5. 不加sudo直接执行docker命令检查效果

```
docker images
```

– 输出如下:

```
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
```

### Step3 docker-compose 安装

#### 1. 切换到root用户

```
sudo -i
```

#### 2. 安装docker-compose

```
curl -L https://get.daocloud.io/docker/compose/releases/download/1.25.1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
```

```
chmod +x /usr/local/bin/docker-compose
```