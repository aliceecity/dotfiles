#!/bin/sh

reminders="$(dirname "$0")/../secret/reminders"
actual_date=$(date +%Y%m%d)

while getopts 'na' opt; do
  case "$opt" in
    n) mc_names=1 ;;
    a) show_all=1 ;;
    *) exit 2     ;;
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
  case $([[ -n "$show_all" ]] && echo -n "a" || echo -n "${reminder:0:1}") in
    ";")
      reminder_date="${reminder:1:8}"
      ((reminder_date <= actual_date)) && echo -e " - ${reminder:9}"
      ;;
    ":")
      reminder_date="${reminder:1:8}"
      ((reminder_date == actual_date)) && echo -e " - ${reminder:9}"
      ;;
    ",")
      reminder_date="${reminder:1:8}"
      days=$((("$(date -d "$reminder_date" +%s)" - "$(date +%s)") / (3600 * 24) + 1))
      printf "%-50b%3s day%s left\n" " - ${reminder:9}" "$days" "$( ((days != 1)) && echo s )"
      ;;
    * )
      echo -e " - $reminder"
      ;;
  esac
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
