set $system "System Control"
bindsym $mod+s mode $system
mode $system {
    # i3 Control
    bindsym Ctrl+c mode "default"; exec ~/.config/i3/process-config.sh; reload
    bindsym Ctrl+r restart

    # Power Control
    bindsym p mode "default"; exec systemctl poweroff
    bindsym r mode "default"; exec systemctl reboot
    bindsym h mode "default"; exec systemctl hibernate
    bindsym s mode "default"; exec systemctl suspend-then-hibernate

    # User Control
    bindsym l mode "default"; exit

    bindsym Escape mode "default"
}
