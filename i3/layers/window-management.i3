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
    # TODO: Switch numbers to variables
    bindsym $left       resize shrink width 10 px or 5 ppt
    bindsym $down       resize grow height 10 px or 5 ppt
    bindsym $up         resize shrink height 10 px or 5 ppt
    bindsym $right      resize grow width 10 px or 5 ppt
    # arrow key alternatives
    bindsym Left        resize shrink width 10 px or 5 ppt
    bindsym Down        resize grow height 10 px or 5 ppt
    bindsym Up          resize shrink height 10 px or 5 ppt
    bindsym Right       resize grow width 10 px or 5 ppt

    bindsym Escape mode "default"
}

# Change focus
bindsym $mod+$left focus left
bindsym $mod+$down focus down
bindsym $mod+$up focus up
bindsym $mod+$right focus right
bindsym $mod+comma focus parent
bindsym $mod+period focus child
# Alternatively, arrow keys
bindsym $mod+Left focus left
bindsym $mod+Down focus down
bindsym $mod+Up focus up
bindsym $mod+Right focus right

# Move focused window
bindsym $mod+Shift+$left move left
bindsym $mod+Shift+$down move down
bindsym $mod+Shift+$up move up
bindsym $mod+Shift+$right move right
# Alternatively, arrow keys
bindsym $mod+Shift+Left move left
bindsym $mod+Shift+Down move down
bindsym $mod+Shift+Up move up
bindsym $mod+Shift+Right move right

# move current workspace to next output
bindsym $mod+Ctrl+$left move workspace to output left
bindsym $mod+Ctrl+$down move workspace to output down
bindsym $mod+Ctrl+$up move workspace to output up
bindsym $mod+Ctrl+$right move workspace to output right
# alternatively, arrow keys
bindsym $mod+Ctrl+Left move workspace to output left
bindsym $mod+Ctrl+Down move workspace to output down
bindsym $mod+Ctrl+Up move workspace to output up
bindsym $mod+Ctrl+Right move workspace to output right

# define names for workspaces
set $ws_1  "1"
set $ws_2  "2"
set $ws_3  "3"
set $ws_4  "4"
set $ws_5  "5"
set $ws_6  "6"
set $ws_7  "7"
set $ws_8  "8"
set $ws_9  "9"
set $ws_10 "10"

# switch to workspace
bindsym $mod+1 workspace $ws_1
bindsym $mod+2 workspace $ws_2
bindsym $mod+3 workspace $ws_3
bindsym $mod+4 workspace $ws_4
bindsym $mod+5 workspace $ws_5
bindsym $mod+6 workspace $ws_6
bindsym $mod+7 workspace $ws_7
bindsym $mod+8 workspace $ws_8
bindsym $mod+9 workspace $ws_9
bindsym $mod+0 workspace $ws_10

# move focused container to workspace
bindsym $mod+Shift+1 move container to workspace $ws_1
bindsym $mod+Shift+2 move container to workspace $ws_2
bindsym $mod+Shift+3 move container to workspace $ws_3
bindsym $mod+Shift+4 move container to workspace $ws_4
bindsym $mod+Shift+5 move container to workspace $ws_5
bindsym $mod+Shift+6 move container to workspace $ws_6
bindsym $mod+Shift+7 move container to workspace $ws_7
bindsym $mod+Shift+8 move container to workspace $ws_8
bindsym $mod+Shift+9 move container to workspace $ws_9
bindsym $mod+Shift+0 move container to workspace $ws_10

# Toggle tiling / floating
bindsym $mod+Shift+space floating toggle
# Change focus between tiling / floating windows
bindsym $mod+space focus mode_toggle

# Show the next scratchpad window or hide the focused scratchpad window.
# If there are multiple scratchpad windows, this command (awkwardly) cycles
# through them.
bindsym $mod+Shift+minus move scratchpad
# move the currently focused window to the scratchpad
bindsym $mod+minus scratchpad show
