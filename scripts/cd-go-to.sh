#!/bin/sh

tty=$(tmux display-message -p '#{pane_tty}')
proc=$(ps -o comm= -t "$tty" | tail -n 1)

dirs=`fd . ~ --type=d`

selected=`echo "$dirs" | fzf --layout=reverse`

if [ -n "$selected" ]; then
  case "$proc" in 
    zsh|bash) tmux send-keys -t "$TMUX_PANE" 'cd ' "$selected" Enter ^L;;
      *) tmux neww -c "$selected";;
  esac
fi
