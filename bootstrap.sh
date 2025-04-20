#!/bin/bash

cd ~/dotfiles/stow

stow common

OS="$(uname -s)"
case "$OS" in
  Darwin)
    echo "Stowing macOS-specific dotfiles..."
    stow macos
    ;;
  Linux)
    if grep -q Microsoft /proc/version; then
      echo "Stowing WSL-specific dotfiles..."
      stow wsl
    else
      echo "Stowing Arch-specific dotfiles..."
      stow arch
    fi
    ;;
esac
