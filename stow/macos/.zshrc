# === Oh My Zsh Setup ===
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="af-magic"
plugins=(git zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh

# === Key Bindings ===
# Ctrl+O launches tmux-sessionizer
bindkey -s '^O' 'source ~/.config/tmux/tmux-sessionizer.sh\n'

# === Environment Variables ===
export PATH="$HOME/.local/bin:$PATH"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# === Editor Preference ===
# Uncomment this if you want to auto-switch editor for SSH sessions
# export EDITOR='nvim'
