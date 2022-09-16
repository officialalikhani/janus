#!/bin/bash

#install_openssl.sh
wget https://ftp.openssl.org/source/openssl-1.1.1k.tar.gz
tar -xzvf openssl-1.1.1k.tar.gz
cd openssl-1.1.1k
./config --prefix=/usr --openssldir=/etc/ssl --libdir=lib no-shared zlib-dynamic
make
make install
touch /etc/profile.d/openssl.sh
echo 'export LD_LIBRARY_PATH=/usr/local/lib:/usr/local/lib64' > /etc/profile.d/openssl.sh
source /etc/profile.d/openssl.sh
