#!/bin/sh

echo "================================="
echo "      ADD NVIDIA DRIVERS"
echo "================================="
# @see https://docs.alliancecan.ca/wiki/Using_cloud_vGPUs

# echo "==========================================\nWget"
# wget http://repo.arbutus.cloud.computecanada.ca/pulp/deb/ubuntu/pool/main/arbutus-cloud-repo_0.1ubuntu20_all.deb

echo "==========================================\ndpkg"
# NOTE: the file should already be in the home directory
sudo dpkg -i /home/ubuntu/arbutus-cloud-repo_0.1ubuntu20_all.deb

echo "==========================================\nInstall tools"
sudo apt-get update && sudo apt-get -y install nvidia-vgpu-kmod nvidia-vgpu-tools nvidia-vgpu-gridd

echo "==========================================\nCheck to see if installed correctly"
nvidia-smi