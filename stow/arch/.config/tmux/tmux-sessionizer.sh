#!/usr/bin/env bash

# Start tmux server if it's not already running
tmux start-server

# Get project directories and prefix them
project_dirs=$(find ~/projects -mindepth 1 -maxdepth 1 -type d 2>/dev/null | sed 's|^|[DIR] |')

# Get dotfiles directory and prefix it manually
dotfiles_dir="$HOME/.dotfiles"
if [ -d "$dotfiles_dir" ]; then
  dotfiles_entry="[DOT] $dotfiles_dir"
else
  dotfiles_entry=""
fi

# Get SSH labels from .ssh_hosts and prefix them
ssh_labels=$(awk -F': ' '{print "[SSH] " $1}' ~/.config/tmux/ssh_hosts)

# Combine all items
items=$(printf "%s\n%s\n%s" "$project_dirs" "$dotfiles_entry" "$ssh_labels" | sed '/^$/d')

# Use fzf to select an item
selection=$(echo "$items" | fzf)

# Handle selection
if [[ $selection == "[DIR]"* ]]; then

  # It's a project directory
  dir=${selection#\[DIR\] }
  parent_folder=$(basename "$(dirname "$dir")")
  selected_folder=$(basename "$dir")
  session_name="${parent_folder}-${selected_folder}"
  session_path="$dir"

elif [[ $selection == "[DOT]"* ]]; then

  # It's the dotfiles directory
  dir=${selection#\[DOT\] }
  parent_folder=$(basename "$(dirname "$dir")")
  selected_folder=$(basename "$dir")
  session_name="dotfiles"
  session_path="$dir"

elif [[ $selection == "[SSH]"* ]]; then

  # It's an SSH host
  label=${selection#\[SSH\] }

  # Get the SSH command from .ssh_hosts
  ssh_command=$(awk -F': ' -v label="$label" '$1 == label {print $2}' ~/.config/tmux/ssh_hosts)

  if [ -z "$ssh_command" ]; then
    echo "SSH command not found for label $label"
    exit 1
  fi

  session_name="ssh-$label"

else
  echo "Invalid selection"
  exit 1
fi

echo "Session: $session_name"

# Create the tmux session if it doesn't exist
if ! tmux has-session -t "$session_name" 2>/dev/null; then

  if [[ $selection == "[DIR]"* || $selection == "[DOT]"* ]]; then
    tmux new-session -s "$session_name" -c "$session_path" -d
  else
    tmux new-session -s "$session_name" -d "$ssh_command"
  fi

fi

# Attach or switch to the tmux session
if [ -n "$TMUX" ]; then
  tmux switch-client -t "$session_name"
else
  tmux attach-session -t "$session_name"
fi
