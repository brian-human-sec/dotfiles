#!/bin/sh

if [ ! -x "$(command -v go)" ]; then
  echo go not installed.
  exit 1
else
  sudo pacman -S go
  # sudo apt install -y golang
  brew install golang
fi

go get -u github.com/fgeller/kt

exit 0