#!/bin/sh

tty=$(tmux display-message -p '#{pane_tty}')
temp=$(ps -o pid=,comm= -t "$tty")
sshpid=$(echo "$temp" | grep ssh | tail -n 1 | awk '{print $1}')
[[ -n "$sshpid" ]] && ssh_cmd=$(ps -o args= -p "$sshpid")

if [[ -n "$sshpid" ]]; then
  cwd=$($ssh_cmd "pwd")
  home=$($ssh_cmd "echo ~")
  fileshome=$($ssh_cmd "fd . ~ --type f -I")
  [[ "$cwd" != "$home" ]] && filescurr=$($ssh_cmd "fd . $cwd --type f -I -H")
else
  cwd=`tmux display-message -p '#{pane_current_path}'`
  fileshome=`fd . ~ --type f -I`
  [[ "$cwd" != "$HOME" ]] && filescurr=`fd . "$cwd" --type f -I -H`
fi

files=$(printf '%s\n' "$fileshome" "$filescurr" | \
  grep -Ev --ignore-case '\.(txt|srt|bin|class|dat|dds|diff|gpg|gradle|gz|jar|java|js|l|y|mas2j|old|output|[Gg]bx|sh|c|rs|nix|md|lock|o|toml|h|lua|asl|py|json|rasi|html|css|conf|jsonc|log)$' | \
  grep -Ev '^.*/[^\.]*$' | \
  grep -Ev '/(instances|jason|target|records)/' | \
  sort -u | \
  sed '/^$/d'
)

selected=`echo "$files" | fzf --layout=reverse`

if [[ -n "$sshpid" ]]; then
  md5_=$($ssh_cmd "md5sum '$selected'")
  tmp_dir="/tmp/open-ssh-${md5_%% *}"
  if [[ ! -e "$tmp_dir" ]]; then
    mkdir "$tmp_dir"
    scp "${ssh_cmd##ssh }:$selected" "$tmp_dir"
  fi
fi

if [[ -n "$selected" ]]; then
  if [[ -n "sshpid" ]]; then
    tmux run-shell "nohup xdg-open $(printf '%q' "$tmp_dir/${selected##*/}") >/dev/null 2>&1 &"
  else
    tmux run-shell "nohup xdg-open $(printf '%q' "$selected") >/dev/null 2>&1 &"
  fi
fi
