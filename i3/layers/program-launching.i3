# Start dmenu (a program launcher)
# bindsym $mod+d exec dmenu_run
# There also is the (new) i3-dmenu-desktop which only displays applications
# shipping a .desktop file. It is a wrapper around dmenu, so you need that
# installed. This just makes it a bit prettier.
bindsym $mod+Return exec --no-startup-id i3-dmenu-desktop

# key string "launch"
bindsym $mod+p mode "launch"
mode "launch" {
    bindsym t mode "default"; exec kitty
    bindsym f mode "default"; exec firefox
    bindsym e mode "default"; exec code

    bindsym Escape mode "default"
}
