#!/bin/bash
export DEBIAN_FRONTEND=noninteractive
export APT_LISTCHANGES_FRONTEND=noninteractive

echo "deb http://httpredir.debian.org/debian jessie-backports main contrib non-free" > /etc/apt/sources.list.d/backports.list
apt update

# install nvidia drivers & CUDA
echo 'install nvidia drivers & cuda'
yes N | apt install --no-upgrade -y -t jessie-backports nvidia-driver nvidia-smi libcuda1
# if resolvconf is not installed, resolv.conf wont update correctly via DHCP
apt install -y resolvconf

# nvidia-docker, manual installation
echo 'install nvidia-docker'
wget -P /tmp https://github.com/NVIDIA/nvidia-docker/releases/download/v1.0.1/nvidia-docker_1.0.1_amd64.tar.xz
tar --strip-components=1 -C /usr/bin -xvf /tmp/nvidia-docker*.tar.xz
cp /usr/lib/x86_64-linux-gnu/libcuda.so* /usr/lib/nvidia/

cp /tmp/nvidia-docker.service /lib/systemd/system/nvidia-docker.service
useradd -r -M -d /var/lib/nvidia-docker -s /usr/sbin/nologin -c "NVIDIA Docker plugin" nvidia-docker
setcap cap_fowner+pe /usr/bin/nvidia-docker-plugin

systemctl daemon-reload
systemctl enable nvidia-docker

