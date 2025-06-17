#!/usr/bin/env bash
set -e

echo "🔧 Cloning Attache..."
git clone https://github.com/richknowles/attache.git "$HOME/.dotfiles"

echo "📦 Installing dependencies..."
if command -v brew >/dev/null; then
  echo "Using Homebrew"
  brew update
  brew install fish stow curl jq speedtest-cli htop lolcat telnet mpg123
else
  echo "❌ Homebrew not found. Please install it and rerun:"
  echo '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
  exit 1
fi

cd "$HOME/.dotfiles"
stow fish attache

curl -s https://attache.richknowles.com/menu.sh > attache/menu.sh
chmod +x attache/menu.sh

echo "✅ Installed — restart your Fish shell."
