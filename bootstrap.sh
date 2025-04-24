#!/bin/bash
set -e

cd ~/dotfiles/stow

info() {
  echo -e "\n🌀 $1"
}

info "Stowing common dotfiles..."
stow common

OS="$(uname -s)"
case "$OS" in
  Darwin)
    info "Stowing macOS-specific dotfiles..."
    stow macos
    ;;
  Linux)
    if grep -q Microsoft /proc/version; then
      info "Stowing WSL-specific dotfiles..."
      stow wsl
    else
      info "Stowing Arch-specific dotfiles..."
      stow arch
    fi
    ;;
esac

info "✅ Dotfiles stowed successfully."
