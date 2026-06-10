#!/bin/sh

pushd ~/dotfiles/nixos >& /dev/null

git diff -U0 '*.nix'
sudo nixos-rebuild switch --flake . | tee nixos-switch.log || (
  cat nixos-switch.log | grep --color error && false)

popd >& /dev/null
