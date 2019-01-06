# define names for workspaces
set $ws_1  "1:web"
set $ws_2  "2:dev"
set $ws_3  "3:test"
set $ws_4  "4"
set $ws_5  "5"
set $ws_6  "6"
set $ws_7  "7"
set $ws_8  "8"
set $ws_9  "9:storage"
set $ws_10 "10:music"

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

# Show the next scratchpad window or hide the focused scratchpad window.
# If there are multiple scratchpad windows, this command (awkwardly) cycles
# through them.
bindsym $mod+Shift+minus move scratchpad
# move the currently focused window to the scratchpad
bindsym $mod+minus scratchpad show
