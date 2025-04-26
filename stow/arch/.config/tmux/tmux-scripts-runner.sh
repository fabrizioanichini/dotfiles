#!/usr/bin/env bash

SCRIPT_FILE="$HOME/.config/tmux/tmux-scripts-list"

if [ ! -f "$SCRIPT_FILE" ]; then
    echo "Script file not found: $SCRIPT_FILE"
    exit 1
fi

SELECTED_SCRIPT=$(cat "$SCRIPT_FILE" | fzf --height=40% --border --reverse)

if [ -z "$SELECTED_SCRIPT" ]; then
    tmux kill-pane
    exit 0
fi

tmux set-buffer "$SELECTED_SCRIPT"

if command -v pbcopy &>/dev/null; then
    echo -n "$SELECTED_SCRIPT" | pbcopy
elif command -v wl-copy &>/dev/null; then
    echo -n "$SELECTED_SCRIPT" | wl-copy
elif command -v xclip &>/dev/null; then
    echo -n "$SELECTED_SCRIPT" | xclip -selection clipboard
else
    # no external clipboard available, but tmux buffer has it
    :
fi

tmux display-message "Copied: $SELECTED_SCRIPT"
sleep 0.5
tmux kill-pane
