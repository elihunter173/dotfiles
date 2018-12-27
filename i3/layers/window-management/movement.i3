# change focus
bindsym $mod+$left focus left
bindsym $mod+$down focus down
bindsym $mod+$up focus up
bindsym $mod+$right focus right
# alternatively, arrow keys
bindsym $mod+Left focus left
bindsym $mod+Down focus down
bindsym $mod+Up focus up
bindsym $mod+Right focus right

# move focused window
bindsym $mod+Shift+$left move left
bindsym $mod+Shift+$down move down
bindsym $mod+Shift+$up move up
bindsym $mod+Shift+$right move right
# alternatively, arrow keys
bindsym $mod+Shift+Left move left
bindsym $mod+Shift+Down move down
bindsym $mod+Shift+Up move up
bindsym $mod+Shift+Right move right

# use mouse+$primary_action to drag floating windows to their wanted position
floating_modifier $mod

bindsym $mod+m mode "movement"
mode "movement" {
    # change focus
    bindsym $left focus left
    bindsym $down focus down
    bindsym $up focus up
    bindsym $right focus right
    # alternatively, arrow keys
    bindsym Left focus left
    bindsym Down focus down
    bindsym Up focus up
    bindsym Right focus right

    # move focused window
    bindsym Shift+$left move left
    bindsym Shift+$down move down
    bindsym Shift+$up move up
    bindsym Shift+$right move right
    # alternatively, arrow keys
    bindsym Shift+Left move left
    bindsym Shift+Down move down
    bindsym Shift+Up move up
    bindsym Shift+Right move right

    # focus the parent container
    bindsym p focus parent
    # Focus the child container
    bindsym c focus child

    bindsym Escape mode "default"
}
