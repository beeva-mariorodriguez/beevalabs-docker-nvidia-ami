#!/bin/bash
export DEBIAN_FRONTEND=noninteractive
export APT_LISTCHANGES_FRONTEND=noninteractive

echo "deb http://httpredir.debian.org/debian jessie-backports main contrib non-free" > /etc/apt/sources.list.d/backports.list
apt update

# install nvidia drivers & CUDA
echo 'install nvidia drivers & cuda'
yes N | apt install --no-upgrade -y -t jessie-backports nvidia-driver nvidia-smi libcuda1
cp /usr/lib/x86_64-linux-gnu/libcuda.so* /usr/lib/nvidia/
# if resolvconf is not installed, resolv.conf wont update correctly via DHCP
apt install -y resolvconf

