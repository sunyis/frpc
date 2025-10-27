#!/bin/sh
echo "检查配置文件..."
if [ ! -f /frp/config/frpc.ini ]; then
    echo "初始化 frpc.ini 配置文件..."
    cp /frp/default-config/frpc.ini /frp/config/frpc.ini
else
    echo "使用现有的 frpc.ini 配置文件"
fi
echo "添加自定义 hosts 条目..."
cat /frp/default-config/custom-hosts >> /etc/hosts
echo "启动 frpc..."
exec /frp/frpc -c /frp/config/frpc.ini