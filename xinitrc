#!/bin/sh

# init script for X11

# load key configuration
xmodmap ~/.config/Xmodmap/Xmodmap

# hide the cursor when a key is pressed
xbanish &

# monitor setup
xrandr --output HDMI1 --primary --left-of DP1

# set background image
feh --no-fehbg --randomize --bg-fill ~/documents/wallpapers/*

# use dbus and i3wm
exec dbus-launch --exit-with-session i3
