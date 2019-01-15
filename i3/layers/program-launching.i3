bindsym $mod+Return exec rofi -theme base16-onedark -show drun
bindsym $mod+Shift+Return exec rofi -theme base16-onedark -show run
bindsym $mod+w exec rofi -theme base16-onedark -show window

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
