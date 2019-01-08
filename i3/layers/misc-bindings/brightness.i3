# Sreen brightness controls
bindsym XF86MonBrightnessUp exec --no-startup-id "xbacklight -inc 5 # increase screen brightness"
bindsym XF86MonBrightnessDown exec --no-startup-id "xbacklight -dec 5 # decrease screen brightness"
bindsym XF86Display exec --no-startup-id "~/.scripts/xbacklight-toggle"
