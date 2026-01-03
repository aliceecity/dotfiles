#!/bin/sh

nix-shell -p "$@"
nohup nix-collect-garbage >& /dev/null &
