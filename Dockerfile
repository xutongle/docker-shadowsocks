FROM debian:jessie

ENV DEBIAN_FRONTEND noninteractive

MAINTAINER Tongle Xu <xutongle@gmail.com>

ENV INSTALL_PREFIX="/usr" \
    PCRE_VERSION=8.40 \
    LIBSODIUM_VERSION=1.0.11 \
    MBEDTLS_VERSION=2.4.0 \
    SS_VERSION=3.0.2 \
    SERVER_ADDR=0.0.0.0 \
    SERVER_PORT=8888 \
    PASSWORD="123456" \
    METHOD="aes-256-cfb" \
    TIMEOUT=300 \
    FAST_OPEN="--fast-open" \
    WORKERS=1

ADD sources.list /etc/apt/sources.list

RUN apt-get update && \
    apt-get -y --no-install-recommends install wget gettext build-essential autoconf libtool libev-dev libudns-dev automake

WORKDIR /tmp

# install libsodium
RUN wget -c --no-check-certificate https://github.com/jedisct1/libsodium/releases/download/${LIBSODIUM_VERSION}/libsodium-${LIBSODIUM_VERSION}.tar.gz && \
    tar xzf libsodium-${LIBSODIUM_VERSION}.tar.gz && \
    cd libsodium-${LIBSODIUM_VERSION} && \
    ./configure --prefix=/usr && \
    make && make install && \
    rm -rf /tmp/*

# install mbedtls
RUN wget -c --no-check-certificate https://tls.mbed.org/download/mbedtls-${MBEDTLS_VERSION}-gpl.tgz && \
    tar xzf mbedtls-${MBEDTLS_VERSION}-gpl.tgz && \
    cd mbedtls-${MBEDTLS_VERSION} && \
    make SHARED=1 CFLAGS=-fPIC && make DESTDIR=/usr install && \
    rm -rf /tmp/*

# install pcre
RUN wget -c --no-check-certificate https://xutl.oss-cn-hangzhou.aliyuncs.com/docker-asset/pcre/pcre-${PCRE_VERSION}.tar.gz && \
    tar xzf pcre-${PCRE_VERSION}.tar.gz && \
    cd pcre-${PCRE_VERSION} && \
    ./configure --prefix=/usr --enable-utf8 && \
    make && make install && \
    rm -rf /tmp/*

# Get the code, build and install
RUN wget -c --no-check-certificate https://xutl.oss-cn-hangzhou.aliyuncs.com/docker-asset/shadowsocks/shadowsocks-libev-${SS_VERSION}.tar.gz && \
    tar xzf shadowsocks-libev-${SS_VERSION}.tar.gz && \
    cd shadowsocks-libev-${SS_VERSION} && \
    ./configure --disable-documentation --prefix=${INSTALL_PREFIX} && \
    make && make install && \
    rm -rf /tmp/*

ADD entrypoint.sh /root/entrypoint.sh
RUN chmod 700 /root/entrypoint.sh

EXPOSE 8888/tcp 8888/udp

# Define the default command.
ENTRYPOINT ["/root/entrypoint.sh"]