#!/bin/sh

sudo systemctl stop NetworkManager

sudo ip link set wlp0s20u7 down
sudo airmon-ng check kill

sudo airmon-ng start wlp0s20u7

echo sudo airmon-ng start wlp0s20u7 1
echo sudo airodump-ng -c 1 wlp0s20u7mon
# sudo iw dev wlp0s20u7 set type monitor
sudo ip link set wlp0s20u7 up

echo sudo airodump-ng wlp0s20u7

# besside-ng -R 'Target Network' wlan0mon

exit 0
