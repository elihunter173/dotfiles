#!/bin/env bash

# Displays a numbered list of all known devices and connects to the one
# specified by the user
# author: Eli W. Hunter
#
# N.B. This will fail if the known bluetooth devices changes between the display
# of the list and the collection of user input.
# Also, this is strictly worse than blueman

if [ $# != 0 ]; then
    echo "USAGE: bluetooth-cli"
    exit
fi

# display a numbered list of all known devices from bluetoothctl
echo "All known bluetooth devices"
bluetoothctl devices | awk '{print NR ") " $3}'

# print prompt and get the line number of the desired device
echo -n "Device to connect to: "
read LINE
echo

# find the device's MAC address from the specified line number
DEVICE_ADDRESS=$(bluetoothctl devices | awk -v n=$LINE 'NR==n {print $2}')
bluetoothctl power on >/dev/null # just in case
bluetoothctl connect $DEVICE_ADDRESS
