# frpc v0.28.2版本
## 项目简介
基于 [fatedier/frp](https://github.com/fatedier/frp) 原版 frp 内网穿透客户端 frpc 的一键安装卸载脚本和 docker 镜像.支持群晖NAS,Linux 服务器和 docker 等多种环境安装部署.

- GitHub [stilleshan/frpc](https://github.com/sunyis/frpc)
- Docker [stilleshan/frpc](https://hub.docker.com/r/wuzhij/frpc)
> *docker image support for linux/amd64 linux/arm64 linux/armv7*

### 1. 服务器
> *本脚本目前同时支持 Linux AMD 和 ARM 架构*

安装
```shell
docker run -d --name frpc --net=host --restart always --privileged=true -v /home/frp:/frp/config wuzhij/frpc:0.28.2
```
说明
```shell
新添加命令参数--net=host,允许docker网络与本地的端口互通, 不需要添加映射本地端口,安装时如果没有添加,删除后,复制命令重新拉取即可, 运行后,只需要替换/home/frp/目录中frpc.ini中的内容为你自己的配置信息,然后重启frpc就可以了。
```
## 2. 一键安装二进制命令
脚本命令,默认安装0.28.2版本
```shell
bash <(wget -qO- https://r2.wuzhij.com/install-frpc.sh)
```
自定义版本脚本命令
```shell
bash <(wget -qO- https://r2.wuzhij.com/install-frpc.sh 0.52.0)
```

使用命令
```shell
执行安装后,到/frp/config/frpc.ini修改配置信息,然后启动
frpc-manager start       # 启动服务
frpc-manager stop       # 停止服务
frpc-manager config     # 编辑配置
frpc-manager status     # 查看状态
frpc-manager uninstal l  # 卸载服务
./install-frpc.sh --help    # 命令尾部添加帮助
```
## 3. 链接
- Blog [www.wuzhij.com](https://www.wuzhij.com)
- QQ群 [303093669](http://qm.qq.com/cgi-bin/qm/qr?_wv=1027&k=T6Iz8NdglTvjSTLlJUcKuxPZp1KhPr7V&authKey=%2FCYhnfb%2FforX4C18MquIXko%2BgqJn1gN7MQu3FisePSXB5KIexAlSBxmEITWB8skz&noverify=0&group_code=303093669)
