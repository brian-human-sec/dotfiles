#!/bin/sh

curl 'https://api.weather.com/v2/pws/observations/current?apiKey=e1f10a1e78da46f5b10a1e78da96f525&units=e&stationId=KMNCOONR65&format=json' | jq '.observations | .[] | .imperial'
# payload=$(curl 'https://api.weather.com/v2/pws/observations/current?apiKey=e1f10a1e78da46f5b10a1e78da96f525&units=e&stationId=KMNCOONR65&format=json')
payload=$(curl 'https://api.weather.com/v2/pws/observations/current?apiKey=e1f10a1e78da46f5b10a1e78da96f525&units=e&stationId=KMNCOONR65&format=json' | jq '.observations | .[] | .imperial')
temp=$(echo $payload | jq '.temp')

# notify-send 'Minneapolis' "$payload"
notify-send 'Minneapolis' "$temp F"

exit 0

# vim: set ft=sh:
