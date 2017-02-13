FROM debian:jessie

ENV DEBIAN_FRONTEND noninteractive

MAINTAINER Tongle Xu <xutongle@gmail.com>

ENV INSTALL_PREFIX="/usr/local" \
    PCRE_VERSION=8.40 \
    VERSION=2.6.3 \
    SERVER_ADDR=0.0.0.0 \
    SERVER_PORT=8888 \
    PASSWORD="123456" \
    METHOD="aes-256-cfb" \
    TIMEOUT=300 \
    WORKERS=1

ADD sources.list /etc/apt/sources.list

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y ca-certificates apt-utils wget build-essential autoconf libtool libssl1.0.0 openssl libssl-dev --no-install-recommends --force-yes && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /tmp

# install pcre
RUN wget -c --no-check-certificate https://xutl.oss-cn-hangzhou.aliyuncs.com/docker-asset/pcre/pcre-${PCRE_VERSION}.tar.gz && \
    tar xzf pcre-${PCRE_VERSION}.tar.gz && \
    cd pcre-${PCRE_VERSION} && \
    ./configure --prefix=${INSTALL_PREFIX} --enable-utf8 && \
    make && make install && \
    rm -rf /tmp/*

# Get the code, build and install
RUN wget -c --no-check-certificate https://xutl.oss-cn-hangzhou.aliyuncs.com/docker-asset/shadowsocks/shadowsocks-libev-${VERSION}.tar.gz && \
    tar xzf shadowsocks-libev-${VERSION}.tar.gz && \
    cd shadowsocks-libev-${VERSION} && \
    ./configure --help && \
    ./configure --disable-documentation --prefix=${INSTALL_PREFIX} && \
    make && make install && \
    rm -rf /tmp/*

ADD entrypoint.sh /root/entrypoint.sh
RUN chmod 700 /root/entrypoint.sh

EXPOSE 8888

# Define the default command.
ENTRYPOINT ["/root/entrypoint.sh"]