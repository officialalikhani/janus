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

At final you need to have this Dockerfile to make janus image.

## Dockerfile
Lets see  janus Dockerfile 
```Dockerfile
FROM ubuntu:18.04

COPY ./* ./
#install-dependencies
RUN bash install-dependencies.sh
#install-CMAKE
RUN bash install-cmake.sh
#install-libsrtp
RUN wget https://github.com/cisco/libsrtp/archive/v2.2.0.tar.gz && \
	tar xfv v2.2.0.tar.gz && \
	cd libsrtp-2.2.0 && \
	./configure --prefix=/usr --enable-openssl && \
	make shared_library &&  make install && \
#install-usrsctp
RUN git clone https://github.com/sctplab/usrsctp && \
	cd usrsctp && \
	./bootstrap && \
	./configure --prefix=/usr && make &&  make install && \ 
#install-libwebsockets
RUN git clone https://libwebsockets.org/repo/libwebsockets && \
	cd libwebsockets && \
	git checkout v3.2.0 && \
	mkdir build && \
	cd build && \
	cmake -DLWS_MAX_SMP=1 -DCMAKE_INSTALL_PREFIX:PATH=/usr -DCMAKE_C_FLAGS="-fpic" .. && \
	make &&  make install && \
#install-mqtt
RUN git clone https://github.com/eclipse/paho.mqtt.c.git && \
	cd paho.mqtt.c && \
	prefix=/usr make install && \
#install-rabbitmqc
RUN git clone https://github.com/alanxz/rabbitmq-c && \
	cd rabbitmq-c && \
	git submodule init && \
	git submodule update && \
	mkdir builds && cd builds && \
	cmake -DCMAKE_INSTALL_PREFIX=/usr .. && \
	make &&  make install
#install-openssl
RUN wget https://ftp.openssl.org/source/openssl-1.1.1k.tar.gz && \
	tar -xzvf openssl-1.1.1k.tar.gz \
	cd openssl-1.1.1k \
	./config --prefix=/usr --openssldir=/etc/ssl --libdir=lib no-shared zlib-dynamic && \
	make \
	make install \
	touch /etc/profile.d/openssl.sh \
	echo 'export LD_LIBRARY_PATH=/usr/local/lib:/usr/local/lib64' > /etc/profile.d/openssl.sh && \
	source /etc/profile.d/openssl.sh && \
#install-janus-gateway
RUN git clone https://github.com/meetecho/janus-gateway.git && \
	cd janus-gateway && \
	sh autogen.sh && \
	./configure --prefix=/opt/janus && \
	make && \
	make insall && \
	make configs && \

EXPOSE 10000-10200/udp
EXPOSE 8188
EXPOSE 8088
EXPOSE 8089
EXPOSE 8889
EXPOSE 8000
EXPOSE 7088
EXPOSE 7089

CMD ["/opt/janus/bin/janus --help"]
```
