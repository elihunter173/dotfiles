#!/bin/env sh

# TODO: Implement proper argument checking. That is, is this actually a percentage?

if [ $# != 1 ]; then
    echo 'Modifies the volume for the currently running audio sink using pactl. It can set'
    echo 'the volume of the sink, adjust the volume of the sink, or toggles whether the'
    echo 'sink is muted or not.'
    echo ''
    echo 'USAGE:'
    echo '    pactl-volume VOLUME_SETTING'
    echo ''
    echo 'VOLUME_SETTING = n%, +/-n%, or M.'
    echo '    n% sets the volume to that percentage.'
    echo '    +/-n% shifts the current volume by that percentage.'
    echo '    M toggles whether the sink is muted or not.'
    echo ""
    echo 'AUTHORS:'
    echo '    * Eli W. Hunter with inspiration from u/cheesy-burrito'
    echo ''
    echo 'SEE:'
    echo '    * https://www.reddit.com/r/i3wm/comments/a0mgqn/how_can_i_make_my_volume_keys_work_for_both_the/'

    exit
fi

# Finds the currently running sink. If there is no currently running sink, default to sink 0
SINK=$(pactl list short sinks | grep RUNNING | cut -f 1)
SINK=${SINK:-0}

if [ "$1" != "M" ]; then
    pactl set-sink-volume $SINK $1
else
    pactl set-sink-mute $SINK toggle
fi
