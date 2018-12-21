# recompile config upon start
exec_always "~/.config/i3/process-config.sh"

bindsym $mod+s mode "system"
mode "system" {
    bindsym Ctrl+c mode "default"; exec ~/.config/i3/process-config.sh; reload
    bindsym Ctrl+r mode "default"; exec ~/.config/i3/process-config.sh; restart
    bindsym p mode "default"; exec systemctl poweroff
    bindsym r mode "default"; exec systemctl reboot
    bindsym h mode "default"; exec systemctl hibernate
    bindsym s mode "default"; exec systemctl suspend-then-hibernate
    bindsym l mode "default"; exit

    bindsym Escape mode "default"
}
