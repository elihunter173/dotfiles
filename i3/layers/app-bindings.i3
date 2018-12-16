# Start dmenu (a program launcher)
# bindsym $mod+d exec dmenu_run
# There also is the (new) i3-dmenu-desktop which only displays applications
# shipping a .desktop file. It is a wrapper around dmenu, so you need that
# installed. This just makes it a bit prettier.
bindsym $mod+Return exec --no-startup-id i3-dmenu-desktop

bindsym $mod+a mode "launch apps"
mode "launch apps" {
    bindsym t exec kitty; mode "default"
    bindsym f exec firefox; mode "default"
    bindsym e exec code; mode "default"

    bindsym Escape mode "default"
}
