#!/usr/bin/env sh

# Turns off all monitors using xrandr.
#
# All possible monitors are turned off, with no regard given to state.
#
# Author: Eli W. Hunter

monitors=$(xrandr --listmonitors | awk 'NR != 1 {print $NF}')

for monitor in $monitors; do
    xrandr --output $monitor --off
done
