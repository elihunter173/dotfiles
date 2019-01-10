# kill focused window
bindsym $mod+q kill
# middle button and modifier over any part of the window kills the window
bindsym --whole-window $mod+button2 kill

# Enter fullscreen mode for the focused container
bindsym $mod+f fullscreen toggle

# workspace layout
bindsym $mod+e mode "default"; layout toggle split
bindsym $mod+t mode "default"; layout tabbed

# horizontal and vertical split
bindsym $mod+s mode "default"; split h
bindsym $mod+v mode "default"; split v

set $resize "Resize"
bindsym $mod+r mode $resize
mode $resize {
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
