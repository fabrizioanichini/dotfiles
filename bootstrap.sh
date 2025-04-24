#!/bin/bash
set -e

cd ~/dotfiles/stow

stow -t ~ common

OS="$(uname -s)"
case "$OS" in
  Darwin)
    echo "Stowing macOS-specific dotfiles..."
    stow -t ~ --adopt macos
    ;;
  Linux)
    if grep -q Microsoft /proc/version; then
      echo "Stowing WSL-specific dotfiles..."
      stow -t ~ --adopt wsl
    else
      echo "Stowing Arch-specific dotfiles..."
      stow -t ~ --adopt arch
    fi
    ;;
esac
