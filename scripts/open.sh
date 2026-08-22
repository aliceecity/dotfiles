#!/bin/sh

cwd=`tmux display-message -p '#{pane_current_path}'`
fileshome=`fd . ~ --type f -I`
[[ "$cwd" != "$HOME" ]] && filescurr=`fd . "$cwd" --type f -I -H`

files=$(printf '%s\n' "$fileshome" "$filescurr" | \
  grep -Ev --ignore-case '\.(bin|class|dat|dds|diff|gpg|gradle|gz|jar|java|js|l|y|mas2j|old|output|[Gg]bx|sh|c|rs|nix|md|lock|o|toml|h|lua|asl|py|json|rasi|html|css|conf|jsonc|log)$' | \
  grep -Ev '^[^\.]*$' | \
  grep -Ev '/(instances|jason|target|records)/' | \
  sort -u | \
  sed '/^$/d'
)

selected=`echo "$files" | fzf --layout=reverse`

if [[ -n "$selected" ]]; then
    tmux run-shell "nohup xdg-open $(printf '%q' "$selected") >/dev/null 2>&1 &"
fi
