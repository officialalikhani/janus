#!/bin/bash
# List of Dependecies
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
