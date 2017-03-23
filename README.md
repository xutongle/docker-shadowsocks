# docker-shadowsocks

#### Environment:

| Environment | Default value |
|-------------|---------------|
| SERVER_ADDR | 0.0.0.0       |
| SERVER_PORT | 1080          |
| PASSWORD    | 123456        |
| METHOD      | aes-256-cfb   |
| TIMEOUT     | 300           |

#### Creating an instance:

    docker run \
        -d \
        --name shadowsocks \
        -p 8888:1080 \
        -p 8888:1080/udp \
        -e PASSWORD=EQdFUYal \
        -e METHOD=aes-256-cfb
        xutongle/shadowsocks-libev

#### Compose example:

    shadowsocks:
      image: xutongle/shadowsocks-libev
      ports:
        - "8888:1080/tcp"
        - "8888:1080/udp"
      environment:
        - PASSWORD=EQdFUYal
        - METHOD=aes-256-cfb
      restart: always

