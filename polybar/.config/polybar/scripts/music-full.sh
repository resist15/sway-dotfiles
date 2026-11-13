#!/bin/bash

STATUS=$(playerctl status 2>/dev/null)

if [ -z "$STATUS" ] || [ "$STATUS" = "No players found" ]; then
    echo "%{F#555555}󰝛  No Media%{F-}"
    exit 0
fi

ARTIST=$(playerctl metadata artist 2>/dev/null | head -c 20)
TITLE=$(playerctl metadata title 2>/dev/null | head -c 25)

[ -z "$ARTIST" ] && ARTIST="Unknown"
[ -z "$TITLE" ]  && TITLE="Unknown"

if [ "$STATUS" = "Playing" ]; then
    PLAY_ICON="%{F#50fa7b}󰏤%{F-}"   # pause icon (it's playing, click = pause)
else
    PLAY_ICON="%{F#f1fa8c}󰐊%{F-}"   # play icon
fi

PREV="%{F#bd93f9}󰒮%{F-}"
NEXT="%{F#bd93f9}󰒭%{F-}"
MUSIC_ICON="%{F#1db954}󰓇%{F-}"

echo "$PREV $PLAY_ICON $NEXT  $MUSIC_ICON $ARTIST - $TITLE"
