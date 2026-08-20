#!/bin/sh

cwd=`tmux display-message -p '#{pane_current_path}'`
fileshome=`fd . ~ --type f -I`
[[ "$cwd" != "$HOME" ]] && filescurr=`fd . "$cwd" --type f -I -H`

files=$(printf '%s\n' "$fileshome" "$filescurr" | \
  grep -Ev '\.([Gg]bx|png|jpe?g|gif|webp|svg|pdf|zip|tar|gz|bz2|xz|7z|mp[34]|m4a|wav|flac|mkv|avi|jar|exe|o|class|dll|so|bin|iso|dmg)$' | \
  grep -Ev '/(instances|jason|target|records)/' | \
  sort -u | \
  sed '/^$/d'
)

selected=`echo "$files" | fzf --layout=reverse --preview='bat --color=always --style=plain {}'`

[[ -n "$selected" ]] && tmux neww -n "${selected##*/}" nvim "$selected"
