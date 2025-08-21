#!/bin/bash

set -eu

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)

# include multiarch support
apt-get update &&
  apt-get -y install binfmt-support &&\
  sudo dpkg --add-architecture amd64 &&\
  apt-get update &&\
  apt-get -y upgrade

# install GCC-related packages
apt-get update && apt-get -y install\
 build-essential\
 binutils-doc\
 cpp-doc\
 gcc-doc\
 g++\
 gdb\
 gdb-doc\
 glibc-doc\
 libblas-dev\
 liblapack-dev\
 liblapack-doc\
 libstdc++-11-doc\
 make\
 make-doc

# install GCC-related packages for amd64
apt-get -y install\
 g++-11-x86-64-linux-gnu\
 gdb-multiarch\
 libc6:amd64\
 libstdc++6:amd64\
 libasan5:amd64\
 libtsan0:amd64\
 libubsan1:amd64\
 libreadline-dev:amd64\
 libblas-dev:amd64\
 liblapack-dev:amd64

# link x86-64 versions of common tools into $SCRIPT_DIR/bin/x86_64-linux-gnu/bin
mkdir -p $SCRIPT_DIR/../bin/x86_64-linux-gnu/bin
for i in addr2line c++filt cpp-11 g++-11 gcc-11 gcov-11 gcov-dump-11 gcov-tool-11 size strings; do \
        ln -s /usr/bin/x86_64-linux-gnu-$i $SCRIPT_DIR/../bin/x86_64-linux-gnu/bin/$i; done && \
  ln -s /usr/bin/x86_64-linux-gnu-cpp-11 $SCRIPT_DIR/../bin/x86_64-linux-gnu/bin/cpp && \
  ln -s /usr/bin/x86_64-linux-gnu-g++-11 $SCRIPT_DIR/../bin/x86_64-linux-gnu/bin/c++ && \
  ln -s /usr/bin/x86_64-linux-gnu-g++-11 $SCRIPT_DIR/../bin/x86_64-linux-gnu/bin/g++ && \
  ln -s /usr/bin/x86_64-linux-gnu-gcc-11 $SCRIPT_DIR/../bin/x86_64-linux-gnu/bin/gcc && \
  ln -s /usr/bin/x86_64-linux-gnu-gcc-11 $SCRIPT_DIR/../bin/x86_64-linux-gnu/bin/cc && \
  ln -s /usr/bin/gdb-multiarch $SCRIPT_DIR/../bin/x86_64-linux-gnu/bin/gdb

# Do main setup
$SCRIPT_DIR/container-setup-common.sh

# Install golang
bash -c "sudo rm -rf /usr/local/go && sudo mkdir /usr/local/go && wget -O - https://go.dev/dl/go1.22.4.linux-arm64.tar.gz | sudo tar -xvz -C /usr/local"

