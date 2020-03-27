#!/bin/sh

if [ ! -f "symbola.zip" ]; then
  wget 'https://fontlibrary.org/assets/downloads/symbola/cf81aeb303c13ce765877d31571dc5c7/symbola.zip'
fi

if [ ! -f "FiraCode_2.zip" ]; then
  wget 'https://github.com/tonsky/FiraCode/releases/download/2/FiraCode_2.zip'
fi

PROJECTS="monofur-fonts.zip jetbrains-fonts.zip symbola.zip FiraCode_2.zip"
for i in $(echo $PROJECTS); do
  cd ~/.fonts || exit
  unzip -o "../$i"
done
fc-cache -vf ~/.fonts/

echo "fc-list | grep -i jet"
fc-list | grep -i "symbo"

exit 0
