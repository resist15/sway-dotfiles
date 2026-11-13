#!/bin/bash

STATUS=$(playerctl status 2>/dev/null)
PLAYER=$(playerctl -l 2>/dev/null | head -1)

if [ -z "$PLAYER" ] || [ "$STATUS" = "No players found" ]; then
    echo "%{F#555555} No Media%{F-}"
    exit 0
fi

ARTIST=$(playerctl metadata artist 2>/dev/null)
TITLE=$(playerctl metadata title 2>/dev/null)

# Truncate long titles
MAX=35
DISPLAY="$ARTIST - $TITLE"
if [ ${#DISPLAY} -gt $MAX ]; then
    DISPLAY="${DISPLAY:0:$MAX}..."
fi

if [ "$STATUS" = "Playing" ]; then
    ICON=" "   # nf-fa-music
else
    ICON=" "   # nf-fa-pause
fi

echo "$ICON $DISPLAY"
