#!/bin/bash

# Remove old Docker packages (if any)
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do
  apt-get remove -y $pkg
done

# Update the system and install necessary packages
apt-get update -y
apt-get install -y ca-certificates curl

# Create a directory to store the GPG key
mkdir -p /etc/apt/keyrings

# Download the GPG key from Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

# Add the Docker repository to the Apt sources list
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update the package list after adding the Docker repository
apt-get update -y

# Install Docker and Docker Compose
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Check the versions of Docker and Docker Compose
docker --version
docker-compose --version

echo "Docker and Docker Compose installed successfully."

