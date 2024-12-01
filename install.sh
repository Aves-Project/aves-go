#!/bin/bash

# Step 1: Remove any existing Go installations
sudo apt remove -y 'golang-*'

# Step 2: Download Go 1.17
wget https://dl.google.com/go/go1.17.linux-amd64.tar.gz

# Step 3: Extract the downloaded archive
sudo tar -C /usr/local -xzf go1.17.linux-amd64.tar.gz

# Step 4: Set up environment variables
echo 'export GOROOT=/usr/local/go' | sudo tee /etc/profile.d/go-1.17.sh
echo 'export PATH=$GOROOT/bin:$PATH' | sudo tee -a /etc/profile.d/go-1.17.sh

# Step 5: Apply the changes
source /etc/profile.d/go-1.17.sh

# Step 6: Verify the installation
go version
