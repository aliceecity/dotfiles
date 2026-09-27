#!/bin/sh

tty=$(tmux display-message -p '#{pane_tty}')
temp=$(ps -o pid=,comm= -t "$tty")
proc=$(echo "$temp" | tail -n 1 | awk '{print $2}')
sshpid=$(echo "$temp" | grep ssh | tail -n 1 | awk '{print $1}')
[[ -n "$sshpid" ]] && ssh_cmd=$(ps -o args= -p "$sshpid")

if [[ -n "$sshpid" ]]; then
  cwd=$($ssh_cmd "pwd")
  home=$($ssh_cmd "echo ~")

  if [[ $($ssh_cmd "command -v fd") ]]; then
    dirshome=$($ssh_cmd "fd . ~ --type d -I")
    [[ "$cwd" != "$home" ]] && dirscurr=$($ssh_cmd "fd . $cwd --type d -I -H")
  else
    dirshome=$($ssh_cmd "find ~ -type d | grep -v \"/\.\"")
    [[ "$cwd" != "$home" ]] && filescurr=$($ssh_cmd "find $cwd | grep \"/$\"")
  fi

  preview="$ssh_cmd \"TERM=xterm-256color ls --color=always {}\""
else
  cwd=`tmux display-message -p '#{pane_current_path}'`
  dirshome=`fd . ~ --type d -I`
  [[ "$cwd" != "$HOME" ]] && dirscurr=`fd . "$cwd" --type d -I -H`
  preview="ls --color=always {}"
fi

dirs=$(printf '%s\n' "$dirshome" "$dirscurr" | \
  grep -Ev '/(instances|jason|target)/' | \
  sort -u | \
  sed '/^$/d'
)

selected=`echo "$dirs" | fzf --layout=reverse --preview="$preview"`

if [ -n "$selected" ]; then
  case "$proc" in
    zsh|bash|ssh) tmux send-keys -t "$TMUX_PANE" ^A ^K 'cd ' "\"$selected\"" Enter ^L ;;
               *) tmux neww -c "$selected" ;;
  esac
fi
