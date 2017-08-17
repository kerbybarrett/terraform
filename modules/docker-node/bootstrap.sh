#!/bin/sh

# Install NTP
sudo apt install --yes ntp

# Download and install Docker
curl -fsSL get.docker.com -o get-docker.sh
sh get-docker.sh

rm get-docker.sh

# Add ubuntu user to Docker group
sudo usermod -aG docker ubuntu

# Update hostname
newhost=$1
oldhost=$(cat /etc/hostname)

sudo sed -i "s/$oldhost/$newhost/g" /etc/hosts
sudo sed -i "s/$oldhost/$newhost/g" /etc/hostname

# Reboot for hostname changes to take effect
sudo reboot