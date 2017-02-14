#!/bin/bash

while getopts "s:p:k:m:t:w:f" OPT; do
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
    f)
        FAST_OPEN="--fast-open";;
  esac
done

echo -e "\033[32mStarting shadowsocks......\033[0m"
/usr/bin/ss-server -s $SERVER_ADDR -p $SERVER_PORT -k "$PASSWORD" -m $METHOD -t $TIMEOUT \
                  -u --workers $WORKERS $FAST_OPEN