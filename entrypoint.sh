#!/bin/bash

SERVER_ADDR=${SERVER_ADDR:-0.0.0.0}
SERVER_PORT=${SERVER_PORT:-8888}
PASSWORD=${PASSWORD:-123456}
METHOD=${METHOD:-aes-256-cfb}
TIMEOUT=${TIMEOUT:-300}
FAST_OPEN=${FAST_OPEN:-""}
WORKERS=${WORKERS:-1}
PREFER_IPV6=${PREFER_IPV6:-""}

while getopts "s:p:k:m:t:w:af" OPT; do
  case $OPT in
    s)
        SERVER_ADDR=$OPTARG;;
    p)
        SERVER_PORT=$OPTARG;;
    k)
        PASSWORD=$OPTARG;;
    m)
        METHOD=$OPTARG;;
    t)
        TIMEOUT=$OPTARG;;
    w)
        WORKERS=$OPTARG;;
    a)
        ONE_TIME_AUTH="-a";;
    f)
        FAST_OPEN="--fast-open";;
    i)
        PREFER_IPV6="--prefer-ipv6";;
  esac
done

echo -e "\033[32mStarting shadowsocks......\033[0m"
/usr/bin/ss-server -s $SERVER_ADDR -p $SERVER_PORT -k "$PASSWORD" -m $METHOD -t $TIMEOUT \
                  --workers $WORKERS $ONE_TIME_AUTH $FAST_OPEN $PREFER_IPV6