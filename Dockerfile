FROM ubuntu:18.04

COPY ./* ./
#install-dependencies
RUN bash install-dependencies.sh
#install-CMAKE
RUN bash install-cmake.sh
#install_openssl
RUN bash install_openssl.sh
#install-libsrtp
RUN cd /tmp && \
        wget https://github.com/cisco/libsrtp/archive/v2.2.0.tar.gz && \
        tar xfv v2.2.0.tar.gz && \
        cd libsrtp-2.2.0 && \
        ./configure --prefix=/usr --enable-openssl && \
        make shared_library &&  make install
#ianstall-usrsctp
RUN cd /tmp && \
        git clone https://github.com/sctplab/usrsctp && \
        cd usrsctp && \
        ./bootstrap && \
        ./configure --prefix=/usr && make &&  make install
#install-libwebsockets
RUN cd /tmp && \
        git clone https://libwebsockets.org/repo/libwebsockets && \
        cd libwebsockets && \
        git checkout v3.2.0 && \
        mkdir build && \
        cd build && \
        cmake -DLWS_MAX_SMP=1 -DCMAKE_INSTALL_PREFIX:PATH=/usr -DCMAKE_C_FLAGS="-fpic" .. && \
        make &&  make install 
#install-mqtt
RUN cd /tmp && \
        git clone https://github.com/eclipse/paho.mqtt.c.git && \
        cd paho.mqtt.c && \
        prefix=/usr make install 
#install-rabbitmqc
RUN cd /tmp && \
        git clone https://github.com/alanxz/rabbitmq-c && \
        cd rabbitmq-c && \
        git submodule init && \
        git submodule update && \
        mkdir builds && cd builds && \
        cmake -DCMAKE_INSTALL_PREFIX=/usr .. && \
        make &&  make install
#install-janus-gateway
RUN cd /root && \
        git clone https://github.com/meetecho/janus-gateway.git && \
        cd janus-gateway && \
        sh autogen.sh && \
        ./configure --prefix=/opt/janus && \
        make && \
        make install && \
        make configs
		
CMD ["/opt/janus/bin/janus"]
EXPOSE 10000-10200/udp
EXPOSE 8188
EXPOSE 8088
EXPOSE 8089
EXPOSE 8889
EXPOSE 8000
EXPOSE 7088
EXPOSE 7089
