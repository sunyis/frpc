FROM alpine:3.8
LABEL maintainer="Stille <stille@ioiox.com>"

# 使用构建参数支持多架构构建
ARG TARGETARCH
ARG TARGETVARIANT
ENV VERSION=0.28.2
ENV TZ=Asia/Shanghai

WORKDIR /

RUN apk add --no-cache tzdata wget \
    && ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone

# 多架构支持
RUN case "${TARGETARCH}" in \
      "amd64") PLATFORM="amd64" ;; \
      "arm64") PLATFORM="arm64" ;; \
      "arm") \
        case "${TARGETVARIANT}" in \
          "v7") PLATFORM="arm" ;; \
          *) PLATFORM="arm" ;; \
        esac ;; \
      *) echo "Unsupported architecture: ${TARGETARCH}"; exit 1 ;; \
    esac \
    && echo "Building for platform: ${PLATFORM}" \
    && wget --no-check-certificate -q -O frp.tar.gz https://github.com/fatedier/frp/releases/download/v${VERSION}/frp_${VERSION}_linux_${PLATFORM}.tar.gz \
    && tar xzf frp.tar.gz \
    && cd frp_${VERSION}_linux_${PLATFORM} \
    && mkdir -p /frp \
    && mv frpc /frp/ \
    # 创建默认配置目录
    && mkdir -p /frp/default-config \
    && mv frpc.ini /frp/default-config/frpc.ini \
    && cd / \
    && rm -rf frp_${VERSION}_linux_${PLATFORM} frp.tar.gz \
    && apk del wget

# 设置可执行权限
RUN chmod +x /frp/frpc

# 创建默认 hosts 条目文件
RUN echo "8.8.8.8 dns.google" > /frp/default-config/custom-hosts

# 暴露配置目录用于映射
VOLUME /frp/config

# 创建智能启动脚本
RUN echo '#!/bin/sh\n\
# 初始化配置目录\n\
if [ ! -f "/frp/config/frpc.ini" ]; then\n\
    echo "📁 Copying default frpc.ini to /frp/config/"\n\
    cp /frp/default-config/frpc.ini /frp/config/frpc.ini\n\
    echo "✅ Default configuration created. Please edit /frp/config/frpc.ini for your needs."\n\
else\n\
    echo "✅ Using existing frpc.ini from /frp/config/"\n\
fi\n\
\n\
# 添加自定义 hosts 条目（需要特权模式）\n\
if [ -f "/frp/default-config/custom-hosts" ]; then\n\
    echo "🌐 Adding custom hosts entries..."\n\
    cat /frp/default-config/custom-hosts >> /etc/hosts\n\
fi\n\
\n\
echo "🚀 Starting frpc with config: /frp/config/frpc.ini"\n\
exec /frp/frpc -c /frp/config/frpc.ini' > /start.sh && chmod +x /start.sh

CMD ["/start.sh"]
