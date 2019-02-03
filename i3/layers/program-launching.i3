bindsym $mod+Return exec rofi -show drun
bindsym $mod+Shift+Return exec rofi -show run
bindsym $mod+w exec rofi -show window

# key string "launch"
set $launch "Launch Program"
bindsym $mod+p mode $launch
mode $launch {
    bindsym t mode "default"; exec kitty
    bindsym b mode "default"; exec firefox
    bindsym Shift+b mode "default"; exec firefox --private-window
    bindsym r mode "default"; exec kitty ranger

    bindsym Escape mode "default"
}
