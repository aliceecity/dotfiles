#!/bin/sh

pushd ~/dotfiles/nixos >& /dev/null

git diff -U0 '*.nix'
sudo nixos-rebuild switch --flake . | tee nixos-switch.log || (
  cat nixos-switch.log | grep --color error && false)
gen=$(nixos-rebuild list-generations | sed -n '2p'| awk '{print $1,$2,$3}')
git commit -am "$gen"

popd >& /dev/null
