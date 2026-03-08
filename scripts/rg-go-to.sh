#!/bin/sh

result=$(
  rg -l --no-ignore "" ~ |
    fzf --layout=reverse \
        --phony \
        --print-query \
        --bind "change:reload:rg -l --no-ignore {q} ~ || true" \
        --preview='line=$(rg -n {q} {} 2>/dev/null | head -1 | cut -d: -f1)
            line=${line:-1}
            start=$((line > 5 ? line - 5 : 1))
            bat --color=always --style=plain --highlight-line=$line --line-range=$start: {}  '
)

query=$(printf '%s\n' "$result" | sed -n '1p')
selected=$(printf '%s\n' "$result" | sed -n '2p')

if [ -n "$selected" ]; then
  filename=`echo "$selected" | awk -F "/" '{print $NF}'`

  tmux neww -n "$filename" nvim -c "/\\v$query" "$selected"
fi
