#!/bin/bash
set -e

cd ~/.dotfiles/stow

info() {
  echo -e "\n🔧 $1"
}

remove_if_exists() {
  local file="$1"
  if [ -f "$HOME/$file" ] && [ ! -L "$HOME/$file" ]; then
    info "Removing existing $file (not a symlink)..."
    rm "$HOME/$file"
  fi
}

remove_if_exists ".bashrc"
remove_if_exists ".bash_profile"

info "Stowing common..."
stow -t ~ common

OS="$(uname -s)"
case "$OS" in
  Darwin)
    info "Stowing macOS-specific dotfiles..."
    stow -t ~ macos
    ;;
  Linux)
    if grep -q Microsoft /proc/version; then
      info "Stowing WSL-specific dotfiles..."
      stow -t ~ wsl
    else
      info "Stowing Arch-specific dotfiles..."
      stow -t ~ arch
    fi
    ;;
esac

info "✅ Dotfiles setup complete."
