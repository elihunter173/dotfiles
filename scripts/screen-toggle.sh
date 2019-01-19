#!/usr/bin/env sh

# Toggles the state of all monitors.
#
# It does this by checking if any monitor is one, if a monitor is on, it runs the toggle_off script
# If all monitors off, it executes the toggle_off script.
#
# Author: Eli W. Hunter

toggle_off="$HOME/.scripts/monitors-off.sh"
toggle_on="$HOME/.scripts/monitors-on.sh"

active_monitors=$(xrandr --listactivemonitors | awk 'NR == 1 {print $NF}')

if [[ "$active_monitors" -eq 0 ]]; then
    $toggle_on
else
    $toggle_off
fi
