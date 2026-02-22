#!/bin/sh

sessions=$(tmux list-sessions | awk -F "(" '{print $1$3}' | tr -d ")")

result=$(printf "%s\n" "$sessions" "new" | fzf --layout reverse | awk -F ":" '{print $1}')

if [ -n "$result" ]; then
  if [ "$result" != "new" ]; then
    tmux switch-client -t "$result"
  else
    read -p "[name] " name
    tmux new-session -d -s "$name"
    tmux switch-client -t "$name"
  fi
fi
