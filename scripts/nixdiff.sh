#!/bin/sh

pushd ~/dotfiles/nixos >& /dev/null

git diff -U0 '*.nix'

popd >& /dev/null
