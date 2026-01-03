#!/bin/sh

upower="$(upower -i /org/freedesktop/UPower/devices/battery_BAT0)"

perc="$(echo "$upower" | grep percentage | awk '{print $2}' | tr -d "%")"
state="$(echo "$upower" | grep state | awk '{print $2}')"

if [ "$state" = "charging" ]; then
  chr="#[fg=yellow]⭍ "
else
  chr=""
fi

if [ $perc -gt 67 ]; then
  col="#[fg=green]"
elif [ $perc -gt 21 ]; then
  col="#[fg=yellow]"
else
  col="#[fg=red]"
fi

echo "$chr$col$perc%"
