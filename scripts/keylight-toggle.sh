#!/bin/sh

# read -p "Temperature: " temp
# read -p "Brightness: " bright
# read -p "State: " state

curl -s --location --request GET 'http://192.168.10.110:9123/elgato/lights' --header 'Accept: application/json' | jq
status=$(curl -s --location --request GET 'http://192.168.10.110:9123/elgato/lights' --header 'Accept: application/json' | jq '.lights | .[].on')
brightness=$(curl -s --location --request GET 'http://192.168.10.110:9123/elgato/lights' --header 'Accept: application/json' | jq '.lights | .[].brightness')
temperature=$(curl -s --location --request GET 'http://192.168.10.110:9123/elgato/lights' --header 'Accept: application/json' | jq '.lights | .[].temperature')


echo "brightness=$brightness"
echo "temperature=$temperature"
if [ "$status" = 0 ]; then
    echo "currently off"
    status=1
else
    echo "currently on"
    status=0
fi

generate_post_data() {

cat <<EOF
{
"lights": [
{
"brightness": $brightness,
"temperature": $temperature,
"on": $status
}
],

"numberOfLights": 1
}
EOF

}

curl -s --location --request PUT 'http://192.168.10.110:9123/elgato/lights' \
--header 'Content-Type: application/json' \
--data "$(generate_post_data)"
