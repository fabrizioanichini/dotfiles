# 🏠 Dotfiles – My Cross-Platform Dev Environment

Welcome to my dotfiles repository. This is the central hub I use to manage and synchronize my developer environment across **macOS**, **Arch Linux**, and **WSL**. Powered by [GNU Stow](https://www.gnu.org/software/stow/), Vim, and the Unix philosophy.

## 🧘 Philosophy

- **Minimalism**: Only what I need, nothing more.
- **Portability**: Seamless experience across macOS, Arch, and WSL.
- **Modularity**: Platform-specific configurations kept isolated.
- **Unix-first**: Built around Vim, terminal, tmux, and CLI tools.

## 📁 Repository Structure

```
dotfiles/
├── README.md
├── bootstrap.sh       # One-shot installation script
└── stow/
    ├── common/        # Shared across all systems
    ├── macos/         # macOS-specific configs
    ├── arch/          # Arch Linux configs
    └── wsl/           # WSL-specific configs
```

Each directory inside `stow/` is a [stow package](https://www.gnu.org/software/stow/manual/stow.html#Concepts) containing symlink-ready dotfiles.

## 🛠️ Managed Tools

- vim/neovim
- zsh
- tmux
- git
- wezterm
- Additional CLI utilities

## ⚙️ Installation

1. Clone the repository:
   ```bash
   git clone git@github.com:yourusername/dotfiles.git ~/dotfiles
   cd ~/dotfiles
   ```

2. Run the bootstrap script (automatically detects your system):
   ```bash
   ./bootstrap.sh
   ```

### Manual Installation

You can also use stow manually:

```bash
cd ~/dotfiles/stow
stow common          # Install shared configs
stow macos           # Install macOS-specific configs
```

To remove symlinks:

```bash
stow -D macos        # Unstow macOS configs
```
