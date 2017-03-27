FROM debian:jessie

ENV DEBIAN_FRONTEND noninteractive

MAINTAINER Tongle Xu <xutongle@gmail.com>

ENV PASSWORD="123456" \
    METHOD="aes-256-cfb" \
    TIMEOUT=300 \
    FAST_OPEN="--fast-open"

ADD entrypoint.sh /root/entrypoint.sh

RUN sh -c 'printf "deb http://httpredir.debian.org/debian jessie-backports main" > /etc/apt/sources.list.d/jessie-backports.list' \
    && apt update \
    && apt -t jessie-backports install -y shadowsocks-libev \
    && rm -rf /var/lib/apt/lists/* \
    && chmod 700 /root/entrypoint.sh

EXPOSE 1080/tcp
EXPOSE 1080/udp

# Define the default command.
ENTRYPOINT ["/root/entrypoint.sh"]