# frpc
## 项目简介
基于 [fatedier/frp](https://github.com/fatedier/frp) 原版 frp 内网穿透客户端 frpc 的一键安装卸载脚本和 docker 镜像.支持群晖NAS,Linux 服务器和 docker 等多种环境安装部署.

- GitHub [stilleshan/frpc](https://github.com/stilleshan/frpc)
- Docker [stilleshan/frpc](https://hub.docker.com/r/stilleshan/frpc)
> *docker image support for X86 and ARM*

### 3. Linux 服务器 一键脚本安装
> *本脚本目前同时支持 Linux X86 和 ARM 架构*

安装
```shell
wget https://raw.githubusercontent.com/stilleshan/frpc/master/frpc_linux_install.sh && chmod +x frpc_linux_install.sh && ./frpc_linux_install.sh
# 以下为国内镜像
wget https://ghfast.top/https://raw.githubusercontent.com/stilleshan/frpc/master/frpc_linux_install.sh && chmod +x frpc_linux_install.sh && ./frpc_linux_install.sh
```

使用
```shell
vi /usr/local/frp/frpc.toml
# 修改 frpc.toml 配置
sudo systemctl restart frpc
# 重启 frpc 服务即可生效
```

卸载
```shell
wget https://raw.githubusercontent.com/stilleshan/frpc/master/frpc_linux_uninstall.sh && chmod +x frpc_linux_uninstall.sh && ./frpc_linux_uninstall.sh
# 以下为国内镜像
wget https://ghfast.top/https://raw.githubusercontent.com/stilleshan/frpc/master/frpc_linux_uninstall.sh && chmod +x frpc_linux_uninstall.sh && ./frpc_linux_uninstall.sh
```

### 4. Linux 服务器 docker 安装
为避免因 **frpc.toml** 文件的挂载,格式或者配置的错误导致容器无法正常运行并循环重启.请确保先配置好 **frpc.toml** 后在运行启动.

**git clone** 本仓库,并正确配置 **frpc.toml** 文件.
```shell
git clone https://github.com/stilleshan/frpc
# git clone 本仓库镜像
git clone https://ghfast.top/https://github.com/stilleshan/frpc
# 国内镜像
vi /root/frpc/frpc.toml
# 配置 frpc.toml 文件
```

执行以下命令启动服务
```shell
docker run -d --name=frpc --restart=always -v /root/frpc/frpc.toml:/frp/frpc.toml stilleshan/frpc
```
> 以上命令 -v 挂载的目录是以 git clone 本仓库为例,也可以在任意位置手动创建 frpc.toml 文件,并修改命令中的挂载路径.

服务运行中修改 **frpc.toml** 配置后需重启 **frpc** 服务.
```shell
vi /root/frp/frpc.toml
# 修改 frpc.toml 配置
docker restart frpc
# 重启 frpc 容器即可生效
```

## 链接
- Blog [www.ioiox.com](https://www.ioiox.com)
