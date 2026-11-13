#!/bin/bash
# Notification toggle (polybar module/dunst). Bell = on, bell-slash = paused.
if [ "$(dunstctl is-paused 2>/dev/null)" = "true" ]; then
    echo $''
else
    echo $''
fi
