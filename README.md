# beevalabs-docker-gpu-ami

packer template for building an aws image based on ubuntu xenial AMI plus nvidia drivers and docker

## instructions

1. download CUDNN (7.1.4 for cuda 9.2) ubuntu packages from https://developer.nvidia.com/rdp/cudnn-download
2. copy ``libcudnn7_7.1.4.18-1+cuda9.2_amd64.deb`` and ``libcudnn7-dev_7.1.4.18-1+cuda9.2_amd64.deb`` to cudnn/
3. ``packer build beevalabs-docker-nvidia.json``

