#!/bin/bash
export DEBIAN_FRONTEND=noninteractive
export APT_LISTCHANGES_FRONTEND=noninteractive

echo "deb http://httpredir.debian.org/debian jessie-backports main contrib non-free" > /etc/apt/sources.list.d/backports.list
apt update

# install nvidia drivers & CUDA
echo 'install nvidia drivers & cuda'
yes N | apt install --no-upgrade -y -t jessie-backports nvidia-driver nvidia-smi libcuda1 nvidia-cuda-mps
#
mkdir -p /usr/local/nvidia/lib64
mkdir -p /usr/local/nvidia/bin
cp /usr/lib/x86_64-linux-gnu/libcuda.so.1 /usr/local/nvidia/lib64/
ln -s libcuda.so /usr/local/nvidia/lib64/libcuda.so.1
cp /usr/lib/x86_64-linux-gnu/libnvidia-fatbinaryloader.so.375.66 /usr/local/nvidia/lib64/
cp /usr/lib/x86_64-linux-gnu/libnvidia-ml.so.1 /usr/local/nvidia/lib64/
cp /usr/bin/nvidia-smi /usr/local/nvidia/bin
# if resolvconf is not installed, resolv.conf wont update correctly via DHCP
apt install -y resolvconf

# nvidia-devicefiles
cp /tmp/nvidia-devicefiles.sh /usr/local/bin
cp /tmp/nvidia-devicefiles.service /etc/systemd/system/nvidia-devicefiles.service
systemctl daemon-reload
systemctl enable nvidia-devicefiles

