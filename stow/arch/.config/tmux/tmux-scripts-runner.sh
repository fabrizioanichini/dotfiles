#!/usr/bin/env bash

SCRIPT_FILE="$HOME/.config/tmux/tmux-scripts-list"

# Ensure the script file exists
if [ ! -f "$SCRIPT_FILE" ]; then
    echo "Script file not found: $SCRIPT_FILE"
    exit 1
fi

# Use FZF to select a command
SELECTED_SCRIPT=$(cat "$SCRIPT_FILE" | fzf --height=40% --border --reverse)

# If nothing was selected, close the pane and exit
[ -z "$SELECTED_SCRIPT" ] && tmux kill-pane && exit 0

# Copy the selected command to the clipboard
if command -v pbcopy &>/dev/null; then
    echo -n "$SELECTED_SCRIPT" | pbcopy
elif command -v wl-copy &>/dev/null; then
    echo -n "$SELECTED_SCRIPT" | wl-copy
elif command -v xclip &>/dev/null; then
    echo -n "$SELECTED_SCRIPT" | xclip -selection clipboard
else
    echo "No clipboard tool found"
    exit 1
fi

# Show a message in tmux and close the pane
tmux display-message "Copied: $SELECTED_SCRIPT"
sleep 0.5
tmux kill-pane
