#!/bin/env bash

# NOTE: Some of the functions in this script would make sense as other scripts.
#       However, since this file is currently the only one that uses them, they
#       they shall remain here for now.

# Toggles the brightness of the display using xbacklight and the contents
# of the .brightness file in the user's home directory.
# author: Eli W. Hunter

# Set up information about the brightness file.
brightness_file="$HOME/.brightness"
brightness_line=2
status_line=1
number_of_lines=2

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

# Resets the brightness file by making it so that it only has the exact number
# of lines specified in $number_of_lines and makes all of those lines blank.
reset_file() {
    echo >$brightness_file
    for i in range{1..$number_of_lines}; do
        echo >>$brightness_file
    done
}

# Reads and returns the brightness in the brightness file.
read_brightness() {
    select_line $brightness_file $brightness_line
}

# Reads and returns the status in the brightness file.
read_status() {
    select_line $brightness_file $status_line
}

# Changes the brightness in the brightness file.
# ARGS:
#     $1 The new brightness.
change_brightness() {
    change_line $brightness_file $brightness_line $1
}

# Changes the screen status in the brightness file.
# ARGS:
#     $1 The new screen status.
change_status() {
    change_line $brightness_file $status_line $1
}

# Update the brightness file
if [ $(read_status) = "off" ]; then
    change_status "on"
else
    # Set up the file
    # This resets the file first the handle cases where there is no brightness
    # file.
    reset_file
    change_brightness $(xbacklight -get)
    change_status "off"
fi

# Update the screen to match the brightness file.
if [ $(read_status) = "on" ]; then
    xbacklight -set $(read_brightness)
else
    # I always assume that the screen is currently on and should be turned off
    # if there is not a brightness file. (Above block should have created one.)
    xbacklight -set 0
fi
