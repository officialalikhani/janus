# Janus installation

Janus is an open source, general purpose, WebRTC server designed and developed by Meetecho. \
And You can pull this image from my docker repository , See my repo "https://hub.docker.com/u/officialalikhani" \
At first you need some dependencies to make and install janus.

Let's see first bash file that install dependencies you need.
```bash
#!/bin/bash
# List of install-dependencies.sh
packagelist=(
    git
    libmicrohttpd-dev
    libjansson-dev
    libssl-dev
    libsrtp-dev
    libsofia-sip-ua-dev
    libglib2.0-dev
    libopus-dev
    libogg-dev
    libcurl4-openssl-dev
    liblua5.3-dev
    libconfig-dev
    pkg-config
    gengetopt
    libtool
    automake
    gtk-doc-tools
    cmake
	  wget
	  curl
    tar
    libnice-dev
    libnanomsg-dev
	  build-essential 
	  libssl-dev
)
apt-get  update
apt-get -y install ${packagelist[@]}
```
And then you need cmake , So for that you can use this file.
```bash
#!/bin/bash
#install-cmake.sh
wget https://github.com/Kitware/CMake/releases/download/v3.20.2/cmake-3.20.2.tar.gz
tar -zxvf cmake-3.20.2.tar.gz
cd cmake-3.20.2
./bootstrap
make 
make install 
```


## Docker-compose
Lets see  the Docker-compose file 
```yml
version: '3.9'
services:
  protonvpn:
    container_name: "container_name"
    environment:
      PROTONVPN_USERNAME: "OpenVPN Username"
      PROTONVPN_PASSWORD: "OpenVPN Password"
      PROTONVPN_SERVER: "ProtonVPN server to connect"
      PROTONVPN_TIER: "Proton VPN Tier "
    image: "officialalikhani/protonvpn:protonvpn"
    restart: unless-stopped
    networks:
      - internet
      - proxy
    cap_add:
      - NET_ADMIN
    devices:
      - /dev/net/tun:/dev/net/tun
    expose:
      - 8000
volumes:
  config:
networks:
  internet:
  proxy:
    internal: true
```

