#!/bin/sh

tty=$(tmux display-message -p '#{pane_tty}')
proc=$(ps -o comm= -t "$tty" | tail -n 1)

dirs=`fd . ~ --type=d`

selected=`echo "$dirs" | fzf --layout=reverse`

if [ -n "$selected" ]; then
  if [ "$proc" = "zsh" ]; then
    tmux send-keys -t "$TMUX_PANE" 'cd ' "$selected" Enter ^L
  else
    tmux neww -c "$selected"
  fi
fi
