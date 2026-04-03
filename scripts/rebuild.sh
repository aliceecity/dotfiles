#!/bin/sh

pushd ~/dotfiles/nixos >& /dev/null

git diff -U0 '*.nix'
tmux split-window -v "watch -n .1 tail ~/dotfiles/nixos/nixos-switch.log"
tmux select-pane -t 1
sudo nixos-rebuild switch --flake . &> nixos-switch.log || (
  cat nixos-switch.log | grep --color error && false)
tmux kill-pane -t 2
gen=$(nixos-rebuild list-generations | sed -n '2p'| awk '{print $1,$2,$3}')
git commit -am "$gen"

popd >& /dev/null
