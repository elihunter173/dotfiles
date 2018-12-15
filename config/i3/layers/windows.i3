# kill focused window
bindsym $mod+q kill
# middle button and modifier over any part of the window kills the window
bindsym --whole-window $mod+button2 kill

# change window orientation (l is taken by movement)
bindsym $mod+o mode "layout"
mode "layout" {
    # workspace layout
    bindsym $mod+r layout toggle split
    bindsym $mod+e layout stacking
    bindsym $mod+t layout tabbed
    # horizontal and vertical split
    bindsym $mod+h split h
    bindsym $mod+v split v

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
