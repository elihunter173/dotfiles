bindsym $mod+Return exec rofi -show drun
bindsym $mod+Shift+Return exec rofi -show run
bindsym $mod+w exec rofi -show window

# key string "launch"
set $launch "Launch Program"
bindsym $mod+p mode $launch
mode $launch {
    bindsym t mode "default"; exec --no-startup-id kitty

    # File Browsing
    bindsym r mode "default"; exec --no-startup-id kitty ranger

    # Web Browsing
    bindsym b mode "default"; exec --no-startup-id firefox
    bindsym Shift+b mode "default"; exec --no-startup-id firefox --private-window
    bindsym s mode "default"; exec --no-startup-id firefox --new-window https://open.spotify.com/browse/featured

    bindsym Escape mode "default"
}
