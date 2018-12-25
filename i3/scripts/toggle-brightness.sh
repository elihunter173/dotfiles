#!/bin/bash

# Selects and returns a single line from a file.
# ARGS:
#     $1 The name of the file to select the line from.
#     $2 The line number to be selected.
select_line() {
    head -n $2 $1 | tail -n 1
}

# Modifies a single line in a file.
# ARGS:
#     $1 The name of the file to have a line changed.
#     $2 The line number to be changed to the new text.
#     $3 The text new text for the given line.
change_line() {
    sed -i "${2}s/.*/${3}/" $1
}

# Set up information about the brightness file.
brightness_file="$HOME/.config/i3/.brightness"
brightness_line=2
status_line=1

# Updates the brightness in the brightness file.
# ARGS:
#     $1 The new brightness.
update_brightness() {
    change_line $brightness_file $brightness_line $1
}

# Updates the screen status in the brightness file.
# ARGS:
#     $1 The new screen status.
update_status() {
    change_line $brightness_file $status_line $1
}

# Read the brightness file.
brightness=$(select_line $brightness_file $brightness_line)
screen_status=$(select_line $brightness_file $status_line)

default_brightness=30

# Update the brightness file
if [ $screen_status = "on" ]; then
    update_brightness $(xbacklight -get)
    update_status "off"
elif [ $screen_status = "off" ]; then
    update_status "on"
else
    printf "\n\n" >$brightness_file
    update_brightness $default_brightness
    update_status "on"
fi

# Read the brightness file.
brightness=$(select_line $brightness_file $brightness_line)
screen_status=$(select_line $brightness_file $status_line)

# Update the screen to match the brightness file.
if [ $screen_status = "on" ]; then
    xbacklight -set $brightness
elif [ $screen_status = "off" ]; then
    xbacklight -set 0
else
    xbacklight -set $default_brightness
fi
