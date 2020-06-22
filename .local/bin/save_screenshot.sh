#!/bin/sh

set -e

OPTIONS="$(date +'screenshot_%Y-%m-%d-%H:%M:%S.png')\n$(ls "$HOME/screenshots")"
FILENAME="$HOME/screenshots/$(echo "$OPTIONS" | dmenu -p 'Save as')"
mv $1 "$FILENAME"
