FROM alpine:3.8
LABEL maintainer="Stille <stille@ioiox.com>"

# 使用构建参数
ARG TARGETARCH
ARG VERSION=0.28.2

ENV VERSION=${VERSION}
ENV TZ=Asia/Shanghai
WORKDIR /

RUN apk add --no-cache tzdata wget \
    && ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone

# 根据 TARGETARCH 映射架构名称
RUN case "${TARGETARCH}" in \
      "amd64") PLATFORM="amd64" ;; \
      "arm64") PLATFORM="arm64" ;; \
      "arm") PLATFORM="arm" ;; \
      *) echo "Unsupported architecture: ${TARGETARCH}"; exit 1 ;; \
    esac \
    && wget --no-check-certificate -O frp.tar.gz https://github.com/fatedier/frp/releases/download/v${VERSION}/frp_${VERSION}_linux_${PLATFORM}.tar.gz \
    && tar xzf frp.tar.gz \
    && cd frp_${VERSION}_linux_${PLATFORM} \
    && mkdir /frp \
    && mv frpc frpc.ini /frp \
    && cd / \
    && rm -rf frp_${VERSION}_linux_${PLATFORM} frp.tar.gz \
    && apk del wget

VOLUME /frp

CMD /frp/frpc -c /frp/frpc.ini
