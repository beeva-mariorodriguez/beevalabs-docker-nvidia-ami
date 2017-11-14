#!/bin/bash
cd /tmp

export DEBIAN_FRONTEND=noninteractive
export APT_LISTCHANGES_FRONTEND=noninteractive

echo "deb http://httpredir.debian.org/debian jessie-backports main contrib non-free" > /etc/apt/sources.list.d/backports.list
echo "deb [arch=amd64] https://download.docker.com/linux/debian jessie stable" >> /etc/apt/sources.list.d/docker.list

wget https://download.docker.com/linux/debian/gpg
apt-key add gpg

apt-get update

# install docker CE
apt-get purge -y docker-engine
apt-get install -y docker-ce
adduser admin docker
# install nvidia drivers & CUDA
echo 'install nvidia drivers & cuda'
yes N | apt-get install --no-upgrade -y -t jessie-backports nvidia-driver nvidia-smi libcuda1 nvidia-cuda-mps
# install nvidia-docker
wget https://github.com/NVIDIA/nvidia-docker/releases/download/v1.0.1/nvidia-docker_1.0.1-1_amd64.deb
systemctl mask nvidia-docker.service
dpkg -i nvidia-docker_1.0.1-1_amd64.deb
systemctl unmask nvidia-docker.service
systemctl enable nvidia-docker.service
# resolvconf
apt-get install -y resolvconf
