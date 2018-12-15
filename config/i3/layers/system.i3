bindsym $mod+s mode "system"
mode "system" {
    bindsym c exec ~/.config/i3/process-config.sh; reload
    bindsym r restart

    bindsym Escape mode "default"
}
