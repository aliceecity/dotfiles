#!/bin/sh

files=`fd . ~ --type=f`
configdir=`fd . ~/.config`

selected=`echo "$files" "$configdir" | fzf --layout=reverse`

if [ -n "$selected" ]; then
  filename=`echo "$selected" | awk -F "/" '{print $NF}'`

  tmux neww -n "$filename" nvim "$selected"
fi
