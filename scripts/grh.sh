#!/bin/sh

if [ -z $1 ]; then
  git commit --amend
else
  git rebase -i HEAD~"$1"
fi
