#!/bin/bash

set -e

echo "🔧 Removing old versions of Docker (if any)..."
sudo apt remove -y docker docker-engine docker.io containerd runc || true

echo "📦 Installing prerequisites..."
sudo apt update
sudo apt install -y ca-certificates curl gnupg lsb-release

echo "🔐 Adding Docker's official GPG key..."
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo "📥 Adding Docker APT repository..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "📦 Updating package lists and installing Docker & Compose plugin..."
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "✅ Installation complete!"
docker --version
docker compose version
