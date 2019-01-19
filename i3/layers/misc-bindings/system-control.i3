# Screen brightness controls
bindsym XF86MonBrightnessUp exec --no-startup-id "xbacklight -inc 2"
bindsym XF86MonBrightnessDown exec --no-startup-id "xbacklight -dec 2"
bindsym XF86Display exec --no-startup-id "~/.scripts/xbacklight-toggle.sh"

set $system "System Control"
bindsym $mod+c mode $system
mode $system {
    # i3 Control
    bindsym Ctrl+c mode "default"; exec --no-startup-id "~/.config/i3/process-config.sh"; reload
    bindsym Ctrl+r restart

    # Power Control
    bindsym p mode "default"; exec --no-startup-id "systemctl poweroff"
    bindsym r mode "default"; exec --no-startup-id "systemctl reboot"
    bindsym h mode "default"; exec --no-startup-id "systemctl hibernate"
    bindsym s mode "default"; exec --no-startup-id "systemctl suspend-then-hibernate"
    bindsym l mode "default"; exec --no-startup-id "dm-tool lock"

    # User Control
    bindsym e mode "default"; exit

    bindsym Escape mode "default"

}
