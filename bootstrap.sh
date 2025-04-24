#!/bin/bash
set -e

cd ~/dotfiles/stow

stow -t ~ common

OS="$(uname -s)"
case "$OS" in
  Darwin)
    echo "Stowing macOS-specific dotfiles..."
    stow -t ~ macos
    ;;
  Linux)
    if grep -q Microsoft /proc/version; then
      echo "Stowing WSL-specific dotfiles..."
      stow -t ~ wsl
    else
      echo "Stowing Arch-specific dotfiles..."
      stow -t ~ arch
    fi
    ;;
esac
