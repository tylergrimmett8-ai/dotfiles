#!/bin/bash
set -euo pipefail

echo "==> Updating package lists..."
sudo apt update -y

# Define tools to install using a variable and a loop
TOOLS=("git" "micro" "tmux")

echo "==> Installing requested tools..."
for tool in "${TOOLS[@]}"; do
	if ! dpkg -s "$tool" >/dev/null 2>&1; then
		sudo apt install -y "$tool"
	else
		echo "$tool is already installed."
	fi
done

# Idempotent dotfile linking
DOTFILE_SOURCE="$HOME/dotfiles/.bashrc"
DOTFILE_TARGET="$HOME/.bashrc"

if [ -f "$DOTFILE_SOURCE" ]; then
	echo "==> Linking dotfile..."
	ln -sf "$DOTFILE_SOURCE" "$DOTFILE_TARGET"
else
	echo "==> Source dotfile not found at $DOTFILE_SOURCE, skipping link."
fi

echo "==> Setup completed successfully!"
