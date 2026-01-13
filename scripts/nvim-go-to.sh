#!/bin/sh

files=`fd . ~ --type f -I | grep -Ev '\.(png|jpe?g|gif|webp|svg|pdf|zip|tar|gz|bz2|xz|7z|mp[34]|wav|flac|mkv|avi|exe|o|dll|so|bin|iso|dmg)$'`

selected=`echo "$files" | fzf --layout=reverse`

if [ -n "$selected" ]; then
  filename=`echo "$selected" | awk -F "/" '{print $NF}'`

  tmux neww -n "$filename" nvim "$selected"
fi
