set $system "System Control"
bindsym $mod+s mode $system
mode $system {
    # i3 Control
    bindsym Ctrl+c mode "default"; exec --no-startup-id "~/.config/i3/process-config.sh"; reload
    bindsym Ctrl+r restart

    # Power Control
    bindsym p mode "default"; exec --no-startup-id "systemctl poweroff"
    bindsym r mode "default"; exec --no-startup-id "systemctl reboot"
    bindsym h mode "default"; exec --no-startup-id "systemctl hibernate"
    bindsym s mode "default"; exec --no-startup-id "systemctl suspend-then-hibernate"

    # User Control
    bindsym l mode "default"; exit

    bindsym Escape mode "default"
}
