#!/bin/bash

echo -e "\033[32mStarting shadowsocks......\033[0m"
/usr/bin/ss-server -s $SERVER_ADDR -p $SERVER_PORT -k "$PASSWORD" -m $METHOD -t $TIMEOUT \
                  -u $FAST_OPEN