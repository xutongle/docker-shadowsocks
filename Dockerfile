FROM debian:jessie

ENV DEBIAN_FRONTEND noninteractive

MAINTAINER Tongle Xu <xutongle@gmail.com>

ENV PASSWORD="123456" \
    METHOD="aes-256-cfb" \
    TIMEOUT=300 \
    FAST_OPEN="--fast-open"

RUN sed -i 's#deb.debian.org#mirrors.aliyun.com#' /etc/apt/sources.list \
    && sed -i 's#security.debian.org#mirrors.aliyun.com/debian-security#' /etc/apt/sources.list \
    && sh -c 'printf "deb http://httpredir.debian.org/debian jessie-backports main" > /etc/apt/sources.list.d/jessie-backports.list' \
    && apt update \
    && apt -t jessie-backports install -y shadowsocks-libev \
    && rm -rf /var/lib/apt/lists/*

ADD entrypoint.sh /root/entrypoint.sh
RUN chmod 700 /root/entrypoint.sh

EXPOSE 1080/tcp 1080/udp

# Define the default command.
ENTRYPOINT ["/root/entrypoint.sh"]