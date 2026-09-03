#!/bin/sh

cwd=`tmux display-message -p '#{pane_current_path}'`
fileshome=`fd . ~ -I`
[[ "$cwd" != "$HOME" ]] && filescurr=`fd . "$cwd" -I -H`

files=$(printf '%s\n' "$fileshome" "$filescurr" | \
  grep -Ev --ignore-case '\.(gbx|png|jpe?g|gif|webp|svg|pdf|zip|tar|gz|bz2|xz|7z|mp[34]|m4a|wav|flac|mkv|avi|jar|exe|o|class|dll|so|bin|iso|dmg)$' | \
  grep -Ev '/(instances|jason|target|records)/' | \
  sort -u | \
  sed '/^$/d'
)

selected=`echo "$files" | fzf --layout=reverse --preview='[[ -d {} ]] && ls --color=always {} || bat --color=always --style=plain {}'`

[[ -n "$selected" ]] && tmux neww -n $(basename "$selected") nvim "$selected"
