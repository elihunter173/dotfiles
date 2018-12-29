# This is from https://faq.i3wm.org/question/3747/enabling-multimedia-keys.1.html
# Pulse Audio controls
bindsym XF86AudioRaiseVolume exec --no-startup-id ~/.scripts/pactl-volume +5%
bindsym XF86AudioLowerVolume exec --no-startup-id ~/.scripts/pactl-volume -5%
bindsym XF86AudioMute exec --no-startup-id ~/.scripts/pactl-volume M

# Media player controls
bindsym XF86AudioPlay exec playerctl play
bindsym XF86AudioPause exec playerctl pause
bindsym XF86AudioNext exec playerctl next
bindsym XF86AudioPrev exec playerctl previous
