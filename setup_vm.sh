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

# add docker CE repo
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
    apt-key add -

add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable"

# add nvidia-docker repo
curl -fsSL https://nvidia.github.io/nvidia-docker/gpgkey | \
  apt-key add -
{
    echo "deb https://nvidia.github.io/libnvidia-container/ubuntu16.04/amd64 /"
    echo "deb https://nvidia.github.io/nvidia-container-runtime/ubuntu16.04/amd64 /"
    echo "deb https://nvidia.github.io/nvidia-docker/ubuntu16.04/amd64 /"
} > /etc/apt/sources.list.d/nvidia-docker.list

apt-get update

# add cuda repo
curl -fsSL https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub | \
    apt-key add -
echo "deb http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64 /" > /etc/apt/sources.list.d/cuda.list

# install docker
echo 'installing docker'
apt-get install -y docker-ce
adduser ubuntu docker
# install nvidia drivers & CUDA
echo 'installing nvidia drivers & cuda'
apt-get install -y nvidia-396 nvidia-modprobe cuda-9.2
# install nvidia-docker2
echo 'installing nvidia-docker'
apt-get install -y nvidia-docker2
# install cudNN
echo 'installing cudNN'
dpkg -i /tmp/cudnn/libcudnn*.deb
# python things
echo 'installing python things'
apt-get install -y python3-pip python3-virtualenv ipython3 ipython3-notebook python3-pycuda

