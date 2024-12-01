#!/bin/bash

# Set up environment variables for Go
echo 'export GOROOT=/usr/local/go' | sudo tee /etc/profile.d/go-1.17.sh
echo 'export PATH=$GOROOT/bin:$PATH' | sudo tee -a /etc/profile.d/go-1.17.sh
source /etc/profile.d/go-1.17.sh

# Optionally, add Go to the current session's PATH
export PATH=$PATH:/usr/local/go/bin

# Run the make command
CGO_ENABLED=0 env GO111MODULE=on go run build/ci.go install ./cmd/geth

# Print the final Go version
go version

make aves
