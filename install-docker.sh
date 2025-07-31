#!/bin/bash

set -e

#echo "Removing old versions of Docker (if any)..."
#sudo apt-get remove -y docker docker-engine docker.io containerd runc

echo "Updating package index..."
sudo apt-get update

echo "Installing prerequisites..."
sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg

echo "Adding Docker’s official GPG key..."
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
    sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo "Setting up the Docker repository..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "Updating package index (with Docker repo)..."
sudo apt-get update

echo "Installing Docker Engine, CLI, and containerd..."
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "Enabling and starting Docker service..."
sudo systemctl enable docker
sudo systemctl start docker

echo "Docker installation complete!"
echo "Test Docker with: sudo docker run hello-world"


# Make the script executable
#chmod +x install-docker.sh

# Note: The above command is for demonstration purposes. It should be run in the terminal to make the script executable.
# The line below is a placeholder for the actual command to make the script executable.

# To run this script, you can use the following command in your terminal:
# ./install-docker.sh
# this line is to run the bash sript after making it executable
# Note: Ensure you have the necessary permissions to run this script.

# If you want to run Docker as a non-root user, you can add your user to the docker group:
#sudo usermod -aG docker $USER
# Note: After running the script, you may need to log out and log back in for the group changes to take effect.