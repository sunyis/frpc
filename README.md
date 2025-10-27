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
docker run -d --name frpc --restart always --privileged=true -v /home/frp:/frp/config wuzhij/frpc:0.28.2
```
说明
```shell
运行后,只需要替换/home/frp/目录中frpc.ini中的内容为你自己的配置信息,然后重启frpc就可以了。
```

## 2. 链接
- Blog [www.wuzhij.com](https://www.wuzhij.com)
- QQ群 [303093669](http://qm.qq.com/cgi-bin/qm/qr?_wv=1027&k=T6Iz8NdglTvjSTLlJUcKuxPZp1KhPr7V&authKey=%2FCYhnfb%2FforX4C18MquIXko%2BgqJn1gN7MQu3FisePSXB5KIexAlSBxmEITWB8skz&noverify=0&group_code=303093669)
