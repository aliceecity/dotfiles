#!/bin/sh

langs=`echo "html,css,rust,bash,c,lua,typst,"`
utils=`echo "awk,sed,find"`

choice=`echo "$langs""$utils" | tr "," "\n" | fzf --layout=reverse`

read -p "[cht.sh/$choice] " query

if echo "$langs" | grep -qs "$choice" ; then
  tmux neww -n "cht.sh/$choice" bash -c "curl cht.sh/$choice/`echo $query | tr " " "+"` | less"
else
  if [ -n "$query" ]; then
    s="~"
  else
    s=""
  fi
  tmux neww -n "cht.sh/$choice" bash -c "curl cht.sh/$choice$s$query | less"
fi
