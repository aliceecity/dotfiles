#!/bin/sh

declare -A nicknames

nicknames=( 
  ["edcr"]="edcrSpeedruns"
  ["silver"]="silverrruns"
  ["mongey"]="bigbigmongey"
  ["bbm"]="bigbigmongey"
)

if [ -v nicknames["$1"] ]; then
  streamer="${nicknames["$1"]}"
else
  streamer="$1"
fi

if [ -z $2 ]; then
  qual="best"
else
  qual="$2"
fi

nohup streamlink twitch.tv/"$streamer" "$qual" >& /dev/null &
