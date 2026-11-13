#!/bin/sh
if [ "$1" = "--toggle" ]; then
  connected=$(bluetoothctl devices Connected | awk '{print $2}')
  if [ -n "$connected" ]; then
    echo "$connected" | xargs -n1 bluetoothctl disconnect
  else
    bluetoothctl devices Paired | awk '{print $2}' | xargs -n1 bluetoothctl connect
  fi
  exit 0
fi

if ! bluetoothctl show | grep -q "Powered: yes"; then
  echo "󰂲 off"
  exit 0
fi

names=$(bluetoothctl devices Connected | cut -d' ' -f3- | paste -sd, -)
if [ -n "$names" ]; then
  echo "󰋋 $names"
else
  echo "󰂯 on"
fi
