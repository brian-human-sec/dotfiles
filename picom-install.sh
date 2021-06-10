#!/bin/sh

sudo pacman -S ninja meson uthash
sudo pkg install -y ninja meson uthash
sudo apt install -y ninja meson uthash-dev
cd "$HOME/projects" || exit
git clone https://github.com/jonaburg/picom
cd picom || exit
meson --buildtype=release . build
ninja -C build
# To install the binaries in /usr/local/bin (optional)
sudo ninja -C build install

exit 0
