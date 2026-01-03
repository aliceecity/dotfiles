#!/bin/sh

for i in $(ps aux | grep "$1" | awk '{print $2}'); do
  echo "killing PID $i"
  kill "$i"
done
