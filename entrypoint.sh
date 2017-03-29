#!/bin/bash

set -e -x

echo -e "\033[32mStarting shadowsocks......\033[0m"

/usr/bin/ss-server -s 0.0.0.0 -p ${SS_PORT} -k "$SS_PASSWORD" -m ${SS_METHOD} -t ${SS_TIMEOUT} -u ${SS_FAST_OPEN}