#!/bin/bash

set -e  # Exit on any error

# Neovim repo and build dir
NVIM_DIR="$HOME/neovim"

echo "Updating Neovim..."

# Install build dependencies if missing (Debian/Ubuntu)
# Uncomment the line below if you want to install dependencies automatically
# sudo apt update && sudo apt install -y ninja-build gettext cmake unzip curl build-essential

# Clone repo if not exists
if [ ! -d "$NVIM_DIR" ]; then
  git clone https://github.com/neovim/neovim.git "$NVIM_DIR"
fi

cd "$NVIM_DIR"

# Fetch latest and reset local changes
git fetch origin
git reset --hard origin/stable

# Build Neovim
make CMAKE_BUILD_TYPE=Release

# Install Neovim (may require sudo depending on your setup)
sudo make install

echo "Neovim updated to:"
nvim --version

