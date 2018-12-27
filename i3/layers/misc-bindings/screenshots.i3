# bind printscreen to taking a screenshot and putting it in the clipoard
bindsym Print exec maim -s | xclip -selection clipboard -t image/png
bindsym Shift+Print exec maim | xclip -selection clipboard -t image/png
