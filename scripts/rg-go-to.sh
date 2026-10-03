#!/bin/sh

tty=$(tmux display-message -p '#{pane_tty}')
temp=$(ps -o pid=,comm= -t "$tty")
sshpid=$(echo "$temp" | grep ssh | tail -n 1 | awk '{print $1}')
[[ -n "$sshpid" ]] && ssh_cmd=$(ps -o args= -p "$sshpid")

if [[ -n "$sshpid" ]]; then
  result=$(
    $ssh_cmd "rg -l \"\" ~" |
      fzf --layout=reverse \
      --phony \
      --print-query \
      --bind "change:reload:$ssh_cmd \"rg -l {q} ~\" || true" \
      --preview='line=$('"$ssh_cmd"' "rg -n {q} {}" 2>/dev/null | head -1 | cut -d: -f1)
    line=${line:-1}
    start=$((line > 5 ? line - 5 : 1))
    '"$ssh_cmd"' "bat --color=always --style=plain --highlight-line=$line --line-range=$start: {}"'
  )
  hostname_=$($ssh_cmd "hostname")
else
  result=$(
    rg -l "" ~ |
      fzf --layout=reverse \
      --phony \
      --print-query \
      --bind "change:reload:rg -l {q} ~ || true" \
      --preview='line=$(rg -n {q} {} 2>/dev/null | head -1 | cut -d: -f1)
    line=${line:-1}
    start=$((line > 5 ? line - 5 : 1))
    bat --color=always --style=plain --highlight-line=$line --line-range=$start: {}'
  )
fi

query=$(printf '%s\n' "$result" | sed -n '1p')
selected=$(printf '%s\n' "$result" | sed -n '2p')

if [[ -n "$selected" ]]; then
  if [[ -n "$sshpid" ]]; then
    tmux neww -c "${selected%/*}/" -n "${selected##*/} [${hostname_:0:1}]" $ssh_cmd -t "nvim -c \"/\\v$query\" $selected"
  else
    tmux neww -c "${selected%/*}/" -n "${selected##*/}" nvim -c "/\\v$query" "$selected"
  fi
fi
