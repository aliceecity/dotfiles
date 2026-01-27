#!/bin/sh

cwd=`tmux display-message -p '#{pane_current_path}'`
fileshome=`fd . ~ --type f -I`
if [ "$cwd" != "$HOME" ]; then
  filescurr=`fd . "$cwd" --type f -I -H`
fi

files=$(printf '%s\n' "$fileshome" "$filescurr" | grep -Ev '\.(png|jpe?g|gif|webp|svg|pdf|zip|tar|gz|bz2|xz|7z|mp[34]|wav|flac|mkv|avi|exe|o|class|dll|so|bin|iso|dmg)$')

selected=`echo "$files" | fzf --layout=reverse`

if [ -n "$selected" ]; then
  filename=`echo "$selected" | awk -F "/" '{print $NF}'`

  tmux neww -n "$filename" nvim "$selected"
fi
