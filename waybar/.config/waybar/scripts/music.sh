#!/bin/bash
# Waybar port of polybar/scripts/music-full.sh (polybar %{F} tags -> Pango spans)

c() { printf "<span color='%s'>%s</span>" "$1" "$2"; }
esc() { sed -e 's/&/\&amp;/g' -e 's/</\&lt;/g' -e 's/>/\&gt;/g'; }

STATUS=$(playerctl status 2>/dev/null)
if [ -z "$STATUS" ] || [ "$STATUS" = "No players found" ]; then
    c "#555555" $'\U000F075B  No Media'
    echo
    exit 0
fi

ARTIST=$(playerctl metadata artist 2>/dev/null | head -c 20 | esc)
TITLE=$(playerctl metadata title 2>/dev/null | head -c 25 | esc)
[ -z "$ARTIST" ] && ARTIST="Unknown"
[ -z "$TITLE" ]  && TITLE="Unknown"

if [ "$STATUS" = "Playing" ]; then
    PLAY=$(c "#50fa7b" $'\U000F03E4')
else
    PLAY=$(c "#f1fa8c" $'\U000F040A')
fi
PREV=$(c "#bd93f9" $'\U000F04AE')
NEXT=$(c "#bd93f9" $'\U000F04AD')
ICON=$(c "#1db954" $'\U000F04C7')

echo "$PREV $PLAY $NEXT  $ICON $ARTIST - $TITLE"
