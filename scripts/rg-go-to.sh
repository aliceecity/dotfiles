#!/bin/sh

selected=$(
  fd . ~ --type=f | fzf --layout=reverse \
                        --phony \
                        --bind "change:reload:rg -l --no-ignore {q} ~ || true"
  )

if [ -n "$selected" ]; then
  filename=`echo "$selected" | awk -F "/" '{print $NF}'`

  tmux neww -n "$filename" nvim "$selected"
fi
