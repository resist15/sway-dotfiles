#!/bin/bash

LOCK="󰌾   Lock"
SUSPEND="󰤄   Suspend"
LOGOUT="󰍃   Logout"
REBOOT="󰜉   Reboot"
SHUTDOWN="󰐥   Shutdown"

CHOSEN=$(echo -e "$LOCK\n$SUSPEND\n$LOGOUT\n$REBOOT\n$SHUTDOWN" \
    | rofi -dmenu \
           -no-fixed-num-lines \
           -p "  System" \
           -theme ~/.config/rofi/powermenu.rasi)

confirm() {
    ANS=$(echo -e "  Yes\n  No" \
        | rofi -dmenu \
               -p "  Confirm" \
               -theme ~/.config/rofi/powermenu.rasi)
    [ "$ANS" = "  Yes" ] && eval "$1"
}

case "$CHOSEN" in
    "$LOCK")     if [ -n "$WAYLAND_DISPLAY" ]; then swaylock -f; else i3lock -c 0f1720; fi ;;
    "$SUSPEND")  systemctl suspend ;;
    "$LOGOUT")   if [ -n "$SWAYSOCK" ]; then confirm "swaymsg exit"; else confirm "i3-msg exit"; fi ;;
    "$REBOOT")   confirm "systemctl reboot" ;;
    "$SHUTDOWN") confirm "systemctl poweroff" ;;
    "$CANCEL")   exit 0 ;;
esac
