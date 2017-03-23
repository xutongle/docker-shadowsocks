#!/bin/bash

echo -e "\033[32mStarting shadowsocks......\033[0m"
/usr/bin/ss-server -s 0.0.0.0 -p 1080 -k "$PASSWORD" -m $METHOD -t $TIMEOUT -u $FAST_OPEN