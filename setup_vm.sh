#!/bin/bash
cd /tmp

export DEBIAN_FRONTEND=noninteractive
export APT_LISTCHANGES_FRONTEND=noninteractive

apt-get update
apt-get install \
    curl \
    jq \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common

# add non-free and contrib repos
{
    echo "deb http://cdn-aws.deb.debian.org/debian stretch main non-free contrib"
    echo "deb http://security.debian.org stretch/updates main non-free contrib"
    echo "deb http://cdn-aws.deb.debian.org/debian stretch-updates main non-free contrib"
    echo "deb http://cdn-aws.deb.debian.org/debian stretch/updates main non-free contrib"
} > /etc/apt/sources.list

# add docker CE repo
curl -s -L https://download.docker.com/linux/debian/gpg | \
  sudo apt-key add -
echo "deb [arch=amd64] https://download.docker.com/linux/debian stretch stable" > /etc/apt/sources.list.d/docker.list

# add nvidia-docker repo
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | \
  sudo apt-key add -
{
    echo "deb https://nvidia.github.io/libnvidia-container/debian9/amd64 /"
    echo "deb https://nvidia.github.io/nvidia-container-runtime/debian9/amd64 /"
    echo "deb https://nvidia.github.io/nvidia-docker/debian9/amd64 /"
} > /etc/apt/sources.list.d/nvidia-docker.list

apt-get update

# install docker
echo 'installing docker'
apt-get install -y docker-ce
adduser admin docker
# install nvidia drivers & CUDA
echo 'installing nvidia drivers & cuda'
apt-get install -y nvidia-driver nvidia-smi libcuda1 nvidia-cuda-mps
# install nvidia-docker2
echo 'installing nvidia-docker'
apt-get install -y nvidia-docker2

