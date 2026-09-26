#!/bin/sh

tty=$(tmux display-message -p '#{pane_tty}')
temp=$(ps -o pid=,comm= -t "$tty")
sshpid=$(echo "$temp" | grep ssh | tail -n 1 | awk '{print $1}')
[[ -n "$sshpid" ]] && ssh_cmd=$(ps -o args= -p "$sshpid")

if [[ -n "$sshpid" ]]; then
  cwd=$($ssh_cmd "pwd")
  home=$($ssh_cmd "echo ~")
  fileshome=$($ssh_cmd "fd . ~ -I")
  [[ "$cwd" != "$home" ]] && filescurr=$($ssh_cmd "fd . $cwd -I -H")
  preview="$ssh_cmd \"[[ -d {} ]] && ls --color=always {} || bat --color=always --style=plain {}\""
  hostname_=$($ssh_cmd "hostname")
else
  cwd=`tmux display-message -p '#{pane_current_path}'`
  fileshome=`fd . ~ -I`
  [[ "$cwd" != "$HOME" ]] && filescurr=`fd . "$cwd" -I -H`
  preview="[[ -d {} ]] && ls --color=always {} || bat --color=always --style=plain {}"
fi

files=$(printf '%s\n' "$fileshome" "$filescurr" | \
  grep -Ev --ignore-case '\.(gbx|png|jpe?g|gif|webp|svg|pdf|zip|tar|gz|bz2|xz|7z|mp[34]|m4a|wav|flac|mkv|avi|jar|exe|o|class|dll|so|bin|iso|dmg)$' | \
  grep -Ev '/(instances|jason|target|records)/' | \
  sort -u | \
  sed '/^$/d'
)

selected=`echo "$files" | fzf --layout=reverse --preview="$preview"`

if [[ -n "$selected" ]]; then
  if [[ -n "$sshpid" ]]; then
    tmux neww -n "$(basename "$selected") [${hostname_:0:1}]" $ssh_cmd -t "nvim $selected"
  else
    tmux neww -n $(basename "$selected") nvim "$selected"
  fi
fi
