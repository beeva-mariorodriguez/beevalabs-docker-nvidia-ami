#!/bin/bash
cd /tmp

export DEBIAN_FRONTEND=noninteractive
export APT_LISTCHANGES_FRONTEND=noninteractive

echo "deb http://cdn-aws.deb.debian.org/debian stretch main non-free contrib" > /etc/apt/sources.list
echo "deb http://security.debian.org stretch/updates main non-free contrib" >> /etc/apt/sources.list
echo "deb http://cdn-aws.deb.debian.org/debian stretch-updates main non-free contrib" >> /etc/apt/sources.list

# install nvidia drivers & CUDA
echo 'installing nvidia drivers & cuda'
apt-get install -y nvidia-driver nvidia-smi libcuda1 nvidia-cuda-mps
# install nvidia-docker
wget https://github.com/NVIDIA/nvidia-docker/releases/download/v1.0.1/nvidia-docker_1.0.1-1_amd64.deb
apt-get install -y sysv-rc libcap2-bin
systemctl mask nvidia-docker.service
dpkg -i nvidia-docker_1.0.1-1_amd64.deb
systemctl unmask nvidia-docker.service
systemctl enable nvidia-docker.service
# install curl
apt-get install -y curl

