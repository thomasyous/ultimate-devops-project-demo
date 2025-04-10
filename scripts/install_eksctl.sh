#!/bin/bash

set -e  # Exit on error

echo "Updating system packages..."
sudo apt update -y

echo "Downloading eksctl..."
curl -sL "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_Linux_amd64.tar.gz" -o eksctl.tar.gz

echo "Extracting eksctl..."
tar -xzf eksctl.tar.gz

echo "Moving eksctl to /usr/local/bin/"
sudo mv eksctl /usr/local/bin/

echo "Cleaning up..."
rm -f eksctl.tar.gz

echo "Verifying eksctl installation..."
eksctl version

echo "eksctl installation completed successfully!"
