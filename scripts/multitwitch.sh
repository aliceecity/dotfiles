#!/bin/sh

for stream in "$@"; do
  ~/dotfiles/scripts/ttv.sh "$stream" worst
done
