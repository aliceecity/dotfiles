#!/bin/sh

sessions=$(tmux list-sessions | sed -e '/attached/d' -e 's/:.*$//')

fzf_result=$(printf "%s\n" "$sessions" | fzf --print-query --layout reverse | awk -F ":" '{print $1}')
query=$(echo "$fzf_result" | sed -n '1p')
result=$(echo "$fzf_result" | sed -n '2p')

if [ -n "$fzf_result" ]; then
  if [ -n "$result" ]; then
    tmux switch-client -t "$result"
  else
    tmux new-session -d -s "$query"
    tmux switch-client -t "$query"
  fi
fi
