# kill focused window
bindsym $mod+q kill
# middle button and modifier over any part of the window kills the window
bindsym --whole-window $mod+button2 kill

# change window layout (l is taken by movement)
# this is a key string
bindsym $mod+o mode "layout"
mode "layout" {
    # workspace layout
    bindsym r mode "default"; layout toggle split
    bindsym e mode "default"; layout stacking
    bindsym t mode "default"; layout tabbed
    # horizontal and vertical split
    bindsym h mode "default"; split h
    bindsym v mode "default"; split v

    bindsym Escape mode "default"
}

bindsym $mod+r mode "resize"
mode "resize" {
    bindsym $left       resize shrink width 10 px or 10 ppt
    bindsym $down       resize grow height 10 px or 10 ppt
    bindsym $up         resize shrink height 10 px or 10 ppt
    bindsym $right      resize grow width 10 px or 10 ppt
    # arrow key alternatives
    bindsym Left        resize shrink width 10 px or 10 ppt
    bindsym Down        resize grow height 10 px or 10 ppt
    bindsym Up          resize shrink height 10 px or 10 ppt
    bindsym Right       resize grow width 10 px or 10 ppt

    bindsym Escape mode "default"
}
