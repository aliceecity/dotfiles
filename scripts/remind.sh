#!/bin/sh

reminders="$(dirname "$0")/../secret/reminders"

while getopts 'n' opt; do
  case "$opt" in
    n) mc_names=1 ;;
    *) exit 2;;
  esac
done

if [[ -f $reminders ]]; then
  . "$reminders"
else
  >&2 echo "No reminders file exists"
  exit 1
fi

echo "reminders:"

for reminder in "${reminders[@]}"; do
    echo -e " - $reminder"
done

if [[ -n $mc_names ]]; then

  # Wait for internet connection and dns resolution
  while ! ping -c 1 google.com &> /dev/null; do 
    sleep 1
  done

  echo -e "\nmc names:"

  for name in "${names[@]}"; do
    code=$(curl -w "%{http_code}" -o /dev/null -s\
      "https://api.mojang.com/users/profiles/minecraft/$name")

    case "$code" in
      200) printf " - %-16s is taken :c\n"              "$name" ;;
      404) printf " - %-16s is available\n"             "$name" ;;
      *)   printf " - %-16s is idk, mojang is stupid\n" "$name" ;;
    esac
  done
fi
