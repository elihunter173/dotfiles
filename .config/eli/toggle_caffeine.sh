#!/usr/bin/env sh

file="$HOME/.config/eli/caffeine"

if [ -f "$file" ]; then
  rm "$file"
else
  echo 'NOSLEEP' > "$file"
fi
killall -SIGUSR1 i3status
