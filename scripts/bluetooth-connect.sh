#!/bin/sh

address=""

pactl load-module module-bluetooth-discover

for address in $(cat /opt/bluetooth.txt);do
  status=$(bluetoothctl info "$address" | grep Connected | grep -v grep)
  echo "status=$status for $address"
  nohup bluetoothctl scan on & >/dev/null 2>&1
  if ! echo "$status" | grep -q "yes"; then
    bluetoothctl remove "$address" >/dev/null 2>&1
    bluetoothctl disconnect "$address" >/dev/null 2>&1
    bluetoothctl trust "$address" >/dev/null 2>&1
    sleep 1
    bluetoothctl connect "$address"
  fi
done

exit 0

# vim: set ft=sh
