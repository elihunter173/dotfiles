# Sreen brightness controls
bindsym XF86MonBrightnessUp exec --no-startup-id "xbacklight -inc 2 # increase screen brightness"
bindsym XF86MonBrightnessDown exec --no-startup-id "xbacklight -dec 2 # decrease screen brightness"
bindsym XF86Display exec --no-startup-id "~/.scripts/xbacklight-toggle"
