#!/bin/sh

cwd=`tmux display-message -p '#{pane_current_path}'`
fileshome=`fd . ~ --type f -I`
if [ "$cwd" != "$HOME" ]; then
  filescurr=`fd . "$cwd" --type f -I -H`
fi

files=$(printf '%s\n' "$fileshome" "$filescurr" | \
  grep -Ev '\.(png|jpe?g|gif|webp|svg|pdf|zip|tar|gz|bz2|xz|7z|mp[34]|m4a|wav|flac|mkv|avi|jar|exe|o|class|dll|so|bin|iso|dmg)$' | \
  grep -Ev '/(jason|target)/' | \
  awk '!seen[$0]++'
)

selected=`echo "$files" | fzf --layout=reverse --preview='bat --color=always --style=plain {}'`

if [ -n "$selected" ]; then
  filename=`echo "$selected" | awk -F "/" '{print $NF}'`

  tmux neww -n "$filename" nvim "$selected"
fi
