#!/bin/bash
cd /tmp

export DEBIAN_FRONTEND=noninteractive
export APT_LISTCHANGES_FRONTEND=noninteractive

echo "deb http://httpredir.debian.org/debian jessie-backports main contrib non-free" > /etc/apt/sources.list.d/backports.list

apt-get update

# install nvidia drivers & CUDA
echo 'install nvidia drivers & cuda'
yes N | apt-get install --no-upgrade -y -t jessie-backports nvidia-driver nvidia-smi libcuda1 nvidia-cuda-mps
# /usr/local/nvidia
mkdir -p /usr/local/nvidia/lib64
mkdir -p /usr/local/nvidia/bin
cp /usr/lib/x86_64-linux-gnu/libcuda.so.1 /usr/local/nvidia/lib64/
ln -s libcuda.so.1 /usr/local/nvidia/lib64/libcuda.so
cp /usr/lib/x86_64-linux-gnu/libnvidia-fatbinaryloader.so.* /usr/local/nvidia/lib64/
cp /usr/lib/x86_64-linux-gnu/libnvidia-ml.so.1 /usr/local/nvidia/lib64/
cp /usr/bin/nvidia-smi /usr/local/nvidia/bin
# resolvconf
apt-get install -y resolvconf
