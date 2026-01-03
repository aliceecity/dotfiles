#!/bin/sh

dirs=`fd . ~ --type=d`

selected=`echo "$dirs" | fzf --layout=reverse`

tmux send-keys -t "$TMUX_PANE" 'cd ' "$selected" Enter ^L
