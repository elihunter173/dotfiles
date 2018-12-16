# eDP1 is the built-in display
# HDMI2 is the dedicated HDMI port
# TODO make it so it handles single monitor setup (udev?)
exec "xrandr --output eDP1 --primary --pos 0x0" 
exec "xrandr --output HDMI2 --pos 1920x-310"
