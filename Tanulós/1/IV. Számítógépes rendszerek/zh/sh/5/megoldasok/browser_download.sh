#!/bin/bash

> downloaded.txt

while IFS= read -r basename
do
  if [ ! -e "$basename" ]; then
    touch "$basename"
    echo "$basename" >> downloaded.txt
  else
    i=1
    while true; do
      new_name="$basename ($i)"

      if [ ! -e "$new_name" ]; then
        touch "$new_name"
        echo "$new_name" >> downloaded.txt
        break
      else
        i=$((i + 1))
      fi
    done
  fi
done < "to_download.txt"
