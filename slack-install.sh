#!/bin/sh

if [ -x "$(command -v pacman)" ]; then
  sudo pacman --noconfirm --needed -S slack
elif [ -x "$(command -v emerge)" ]; then
  sudo emerge --update --newuse slack
elif [ -x "$(command -v apt)" ]; then
  echo
elif [ -x "$(command -v xbps-install)" ]; then
  echo
elif [ -x "$(command -v eopkg)" ]; then
  echo
elif [ -x "$(command -v dnf)" ]; then
  echo
elif [ -x "$(command -v brew)" ]; then
  echo
else
  echo "$OS is not yet implemented."
  exit 1
fi

exit 0
