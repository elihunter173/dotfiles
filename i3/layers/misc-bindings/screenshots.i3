# bind printscreen to taking a screenshot and putting it in the clipoard
bindsym Print exec --no-startup-id "maim -s > ~/Pictures/screenshots/$(date --iso-8601=seconds).png"
bindsym Shift+Print exec --no-startup-id "maim > ~/Pictures/screenshots/$(date --iso-8601=seconds).png"
