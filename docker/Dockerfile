FROM ubuntu:focal

# set environment variables for tzdata
ARG TZ=America/New_York
ENV TZ=${TZ}

# include manual pages and documentation
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update &&\
  yes | unminimize

# install GCC-related packages
RUN apt-get -y install\
 build-essential\
 binutils-doc\
 cpp-doc\
 gcc-doc\
 g++\
 g++-multilib\
 gdb\
 gdb-doc\
 glibc-doc\
 libblas-dev\
 liblapack-dev\
 liblapack-doc\
 libstdc++-10-doc\
 make\
 make-doc

# install clang-related packages
RUN apt-get -y install\
 clang\
 clang-10-doc\
 lldb\
 clang-format

# install programs used for system exploration
RUN apt-get -y install\
 blktrace\
 linux-tools-generic\
 strace\
 tcpdump\
 htop

# install interactive programs (emacs, vim, nano, man, sudo, etc.)
RUN apt-get -y install\
 bc\
 curl\
 dc\
 git\
 git-doc\
 man\
 micro\
 nano\
 psmisc\
 sudo\
 wget\
 emacs-nox\
 vim

RUN echo "wireshark-common wireshark-common/install-setuid boolean true" | sudo debconf-set-selections

# Install graphical apps
RUN apt-get -y install\
 wireshark \
 xterm \
 x11-xserver-utils

# install rust
RUN RUSTUP_HOME=/opt/rust CARGO_HOME=/opt/rust \
 bash -c "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sudo -E sh -s -- -y"

# Install golang
RUN bash -c "mkdir /usr/local/go && wget -O - https://go.dev/dl/go1.17.7.linux-amd64.tar.gz | sudo tar -xvz -C /usr/local"

# set up libraries
RUN apt-get -y install\
 libreadline-dev\
 locales\
 wamerican\
 libssl-dev

# install programs used for networking
RUN apt-get -y install\
 dnsutils\
 inetutils-ping\
 iproute2\
 net-tools\
 netcat\
 telnet\
 time\
 traceroute

# Install xpra
RUN UBUNTU_VERSION=$(cat /etc/os-release | grep UBUNTU_CODENAME | sed 's/UBUNTU_CODENAME=//') && \
    curl http://xpra.org/gpg.asc | apt-key add - && \
    echo "deb http://xpra.org/ $UBUNTU_VERSION main" >> /etc/apt/sources.list.d/xpra.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends xpra xpra-html5

# set up default locale
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8

# remove unneeded .deb files
RUN rm -r /var/lib/apt/lists/*

# set up passwordless sudo for user cs1680-user
RUN useradd -m -s /bin/bash cs1680-user && \
  echo "cs1680-user ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers.d/cs1680-init

# Add user to the wireshark group
RUN usermod -a -G wireshark cs1680-user

# create binary reporting version of dockerfile
RUN (echo '#\!/bin/sh'; echo 'echo 1') > /usr/bin/cs1680-docker-version; chmod ugo+rx,u+w,go-w /usr/bin/cs1680-docker-version

# git build arguments
ARG USER=cs1680\ User
ARG EMAIL=nobody@example.com

# configure your environment
USER cs1680-user
RUN rm -f ~/.bash_logout

WORKDIR /home/cs1680
CMD ["/bin/bash", "-l"]
