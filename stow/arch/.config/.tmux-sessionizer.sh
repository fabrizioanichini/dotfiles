#!/usr/bin/env bash

# Start tmux server if it's not already running
tmux start-server

# Get directories and prefix them
dirs=$(find ~/projects -mindepth 1 -maxdepth 1 -type d | sed 's|^|[DIR] |')

# Get SSH labels from .ssh_hosts and prefix them
ssh_labels=$(awk -F': ' '{print "[SSH] " $1}' ~/.ssh_hosts)

# Combine directories and SSH labels
items=$(printf "%s\n%s" "$dirs" "$ssh_labels")

# Use fzf to select an item
selection=$(echo "$items" | fzf)

if [[ $selection == "[DIR]"* ]]; then

  # It's a directory
  dir=${selection#\[DIR\] }
  parent_folder=$(basename "$(dirname "$dir")")
  selected_folder=$(basename "$dir")
  session_name="${parent_folder}-${selected_folder}"
  session_path="$dir"

elif [[ $selection == "[SSH]"* ]]; then

  # It's an SSH host
  label=${selection#\[SSH\] }

  # Get the SSH command from .ssh_hosts
  ssh_command=$(awk -F': ' -v label="$label" '$1 == label {print $2}' ~/.ssh_hosts)

  if [ -z "$ssh_command" ]; then
    echo "SSH command not found for label $label"
    exit 1
  fi

  session_name="ssh-$label"

else
  echo "Invalid selection"
  exit 1
fi

echo "session $session_name"

# Create the tmux session if it doesn't exist
if ! tmux has-session -t "$session_name" 2>/dev/null; then

  if [[ $selection == "[DIR]"* ]]; then
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

