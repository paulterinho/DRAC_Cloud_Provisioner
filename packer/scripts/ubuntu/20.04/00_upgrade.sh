#!/bin/sh

echo "================================="
echo "      UPGRADE"
echo "================================="

# echo "==========================================\nCheck DNS server"
# cat /etc/resolv.conf

# echo "==========================================\nUpdate"
sudo apt-get update

echo "==========================================\nUpgrade"
sudo apt-get -y dist-upgrade

echo "==========================================\nReboot"
sudo reboot  # Reboot has to be on the last line.