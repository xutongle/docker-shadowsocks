# docker-shadowsocks

#### Environment:

| Environment | Default value |
|-------------|---------------|
| SERVER_ADDR | 0.0.0.0       |
| SERVER_PORT | 8888          |
| PASSWORD    | $(hostname)   |
| METHOD      | aes-128-gcm   |
| TIMEOUT     | 300           |
| DNS_ADDR    | 8.8.8.8       |
| DNS_ADDR_2  | 8.8.4.4       |

#### Creating an instance:

    docker run \
        -d \
        --name shadowsocks \
        -p 8888:8888 \
        -p 8888:8888/udp \
        -e PASSWORD=EQdFUYal \
        -e METHOD=aes-256-cfb
        gists/shadowsocks-libev

#### Compose example:

    shadowsocks:
      image: xutongle/shadowsocks-libev
      ports:
        - "8888:8888/tcp"
        - "8888:8888/udp"
      environment:
        - PASSWORD=EQdFUYal
        - METHOD=aes-256-cfb
      restart: always

