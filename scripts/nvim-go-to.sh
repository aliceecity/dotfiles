#!/bin/sh

files=`rg "" -l --no-ignore ~`

selected=`echo "$files" | fzf --layout=reverse`

if [ -n "$selected" ]; then
  filename=`echo "$selected" | awk -F "/" '{print $NF}'`

  tmux neww -n "$filename" nvim "$selected"
fi
