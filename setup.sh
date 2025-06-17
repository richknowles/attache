#!/usr/bin/env bash
set -e

echo "🔧 Cloning Attache..."
git clone https://github.com/richknowles/attache.git "$HOME/.dotfiles"

echo "📦 Installing deps..."
if [ -f /etc/debian_version ]; then
  sudo apt update && sudo apt install -y fish stow curl jq speedtest-cli htop
elif [ -f /etc/fedora-release ]; then
  sudo dnf install -y fish stow curl jq speedtest-cli htop
elif [ -f /etc/arch-release ]; then
  sudo pacman -Syu --noconfirm fish stow curl jq speedtest-cli htop
fi

cd "$HOME/.dotfiles"
stow fish attache

curl -s https://attache.richknowles.com/menu.sh > attache/menu.sh
chmod +x attache/menu.sh

echo "✅ Installed — restart your Fish shell."
