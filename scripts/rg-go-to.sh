#!/bin/sh

result=$(
  rg -l --no-ignore "" ~ |
    fzf --layout=reverse \
        --phony \
        --print-query \
        --bind "change:reload:rg -l --no-ignore {q} ~ || true"
)

query=$(printf '%s\n' "$result" | sed -n '1p')
selected=$(printf '%s\n' "$result" | sed -n '2p')

if [ -n "$selected" ]; then
  filename=`echo "$selected" | awk -F "/" '{print $NF}'`

  tmux neww -n "$filename" nvim -c "/\\v$query" "$selected"
fi
