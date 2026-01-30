#!/bin/sh

tty=$(tmux display-message -p '#{pane_tty}')
proc=$(ps -o comm= -t "$tty" | tail -n 1)

cwd=`tmux display-message -p '#{pane_current_path}'`
dirshome=`fd . ~ --type d -I`
if [ "$cwd" != "$HOME" ]; then
  dirscurr=`fd . "$cwd" --type d -I -H`
fi

dirs=$(printf '%s\n' "$dirshome" "$dirscurr")

selected=`echo "$dirs" | fzf --layout=reverse`

if [ -n "$selected" ]; then
  case "$proc" in
    zsh|bash) tmux send-keys -t "$TMUX_PANE" 'cd ' "$selected" Enter ^L;;
      *) tmux neww -c "$selected";;
  esac
fi
