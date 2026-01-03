#!/bin/sh

for stream in "$@"; do
  ./ttv.sh "$stream" worst
done
