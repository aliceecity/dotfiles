#!/bin/sh

files=`fd . ~ --type=f`

selected=`echo "$files" | fzf --layout=reverse`

if [ -n "$selected" ]; then
  filename=`echo "$selected" | awk -F "/" '{print $NF}'`

  tmux neww -n "$filename" nvim "$selected"
fi
