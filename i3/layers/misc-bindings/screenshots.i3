# bind printscreen to taking a screenshot and putting it in the clipoard
bindsym Print exec --no-startup-id "mkdir /tmp/screenshots; maim -s > /tmp/screenshots/$(date --iso-8601=seconds).png"
bindsym Shift+Print exec --no-startup-id "mkdir /tmp/screenshots; maim > /tmp/screenshots/$(date --iso-8601=seconds).png"
