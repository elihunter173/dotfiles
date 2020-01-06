#!/usr/bin/env bash

# Terminate already running bar instances. If we failed to terminate anything,
# we're launching on startup and need to wait for Plasma to start up for ewhm.
killall -q -w polybar || sleep 1

# Launch bars
polybar top &

echo "Polybar launched..."
