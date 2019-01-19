#!/usr/bin/env sh

# Turns on all monitors, that have been set up, using xrandr.
#
# Note: All monitors must be manually set up to be turned on by this script.
#
# Author: Eli W. Hunter

# Turn on monitors in appropriate locations
xrandr --output $MAIN_MONITOR --auto --primary
xrandr --output $RIGHT_MONITOR --auto --right-of $MAIN_MONITOR
xrandr --output $LEFT_MONITOR --auto --left-of $MAIN_MONITOR

# Reset background
$HOME/.fehbg
