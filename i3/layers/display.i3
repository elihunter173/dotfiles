### CORE MONITOR SETUP
# eDP1 is the built-in display
# HDMI2 is the dedicated HDMI port
# TODO make it so it handles single monitor setup (udev?)
exec "xrandr --output eDP1 --primary --pos 0x0"
exec "xrandr --output HDMI2 --pos 1920x-310"

### DISPLAY SETUP
# set background
exec feh --bg-fill ~/Pictures/carina-nebula.jpg
font pango:Noto Sans 8

for_window [class="^.*"] border none
# TODO: enable compton

# set gaps
gaps inner 10
gaps outer 5
