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

brightness_file="$HOME/.config/i3/.brightness"
brightness_line=2
status_line=1

brightness=$(select_line $brightness_file $brightness_line)
screen_status=$(select_line $brightness_file $status_line)

if [ $screen_status = "on" ]; then
    change_line $brightness_file $brightness_line $(xbacklight -get)
    change_line $brightness_file $status_line "off"
    xbacklight -set 0 # Turn off the screen
elif [ $screen_status = "off" ]; then
    change_line $brightness_file $status_line "on"
    xbacklight -set $brightness # Reset the screen brightness
else
    default_brightness=50
    printf "\n\n" >$brightness_file
    change_line $brightness_file $brightness_line $default_brightness
    change_line $brightness_file $status_line "on"
    xbacklight -set $default_brightness
fi
