#!/bin/sh

sudo apt install libdbus-1-dev libx11-dev libxinerama-dev libxrandr-dev libxss-dev libglib2.0-dev libpango1.0-dev libgtk-3-dev libxdg-basedir-dev libnotify-dev

mkdir -p "$HOME/projects/github.com/dunst-project"
cd "$HOME/projects/github.com/dunst-project" || exit
git clone --recursive git@github.com:dunst-project/dunst.git
cd dunst || exit
make
sudo make install
cd -

exit 0
