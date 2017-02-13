FROM xutongle/dependent:latest

ENV DEBIAN_FRONTEND noninteractive

MAINTAINER Tongle Xu <xutongle@gmail.com>

ENV INSTALL_PREFIX="/usr" \
    PCRE_VERSION=8.40 \
    VERSION=2.6.3 \
    SERVER_ADDR=0.0.0.0 \
    SERVER_PORT=8888 \
    PASSWORD="123456" \
    METHOD="aes-256-cfb" \
    TIMEOUT=300 \
    WORKERS=1

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y --no-install-recommends wget build-essential autoconf libtool && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /tmp

# Get the code, build and install
RUN wget -c --no-check-certificate https://xutl.oss-cn-hangzhou.aliyuncs.com/docker-asset/shadowsocks/shadowsocks-libev-${VERSION}.tar.gz && \
    tar xzf shadowsocks-libev-${VERSION}.tar.gz && \
    cd shadowsocks-libev-${VERSION} && \
    ./configure --with-openssl=/usr --with-openssl-lib=/lib/x86_64-linux-gnu/ --disable-documentation --prefix=${INSTALL_PREFIX} && \
    make && make install && \
    rm -rf /tmp/*

ADD entrypoint.sh /root/entrypoint.sh
RUN chmod 700 /root/entrypoint.sh

EXPOSE 8888

# Define the default command.
ENTRYPOINT ["/root/entrypoint.sh"]