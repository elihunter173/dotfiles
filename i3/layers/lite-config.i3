# i3 config file (v4)
#
# Please see https://i3wm.org/docs/userguide.html for a complete reference!
#
# This config file uses keycodes (bindsym) and was written for the QWERTY
# layout.
#
# To get a config file with the same key positions, but for your current
# layout, use the i3-config-wizard
#

# This font is widely installed, provides lots of unicode glyphs, right-to-left
# text rendering and scalability on retina/hidpi displays (thanks to pango).
#font pango:DejaVu Sans Mono 8

# Before i3 v4.8, we used to recommend this one as the default:
# font -misc-fixed-medium-r-normal--13-120-75-75-C-70-iso10646-1
# The font above is very space-efficient, that is, it looks good, sharp and
# clear in small sizes. However, its unicode glyph coverage is limited, the old
# X core fonts rendering does not support right-to-left and this being a bitmap
# font, it doesn t scale on retina/hidpi displays.


### Display Settings ###

# Font for window titles. Will also be used by the bar unless a different font
# is used in the bar {} block below.

# Start i3bar to display a workspace bar (plus the system information i3status
# finds out, if available)
bar {
    status_command i3status
}


### ###

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
