### Window Manipulation ###

# Toggle tiling / floating
bindsym $mod+Shift+space floating toggle
# Change focus between tiling / floating windows
bindsym $mod+space focus mode_toggle

# move the currently focused window to the scratchpad
bindsym $mod+Shift+minus move scratchpad
# Show the next scratchpad window or hide the focused scratchpad window.
# If there are multiple scratchpad windows, this command (awkwardly) cycles
# through them.
bindsym $mod+minus scratchpad show

# Enter fullscreen mode for the focused container
bindsym $mod+f fullscreen toggle
