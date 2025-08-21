#!/bin/bash

set -eu

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
target_user="${1:-cs1680-user}"

# set up libraries
apt-get -y install libreadline-dev locales wamerican libssl-dev

# install programs used for system exploration
apt-get -y install blktrace linux-tools-generic strace tcpdump htop

apt-get install -y python3 \
  python3-pip \
  python3-dev \
  python3-setuptools \
  python3-venv

# install interactive programs (emacs, vim, nano, man, sudo, etc.)
apt-get -y install bc curl dc git git-doc man micro nano psmisc sudo wget screen tmux emacs-nox vim jq \
  file

# install programs used for networking
apt-get -y install dnsutils inetutils-ping iproute2 net-tools netcat-openbsd telnet time pv traceroute iperf3 whois

# install extra programs for assignments
apt-get -y install \
  python3-scapy \
  python3-pexpect \
  python3-requests

apt-get -y install \
  golang-goprotobuf-dev golang-google-protobuf-dev

echo "wireshark-common wireshark-common/install-setuid boolean true" | sudo debconf-set-selections

# Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# ###### Graphical setup ######
# Install wireshark and xterm (as a graphical demo)
apt-get -y install xterm wireshark tshark

# Install xpra (used for backup display method if X11 forwarding doesn't work)
UBUNTU_VERSION=$(cat /etc/os-release | grep UBUNTU_CODENAME | sed 's/UBUNTU_CODENAME=//') &&
  curl http://xpra.org/gpg.asc | apt-key add - &&
  echo "deb http://xpra.org/ $UBUNTU_VERSION main" >>/etc/apt/sources.list.d/xpra.list
apt-get update &&
  apt-get install -y --no-install-recommends xpra xpra-html5 xpra-x11

# #############################

# Can't user to the wireshark group
# Decrease permissions on dumpcap instead
sudo chmod 755 /usr/bin/dumpcap
