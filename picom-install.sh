#!/bin/sh

if [ "$OS" = "Arch Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  sudo pacman --noconfirm --needed -S ninja meson uthash
elif [ "$OS" = "FreeBSD" ]; then
  sudo pkg install -y ninja meson uthash
elif [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  sudo apt install -y uthash-dev libxcb-sync-dev libxcb-present-dev libxcb-damage0-dev libconfig-dev libdbus-1-dev
  sudo apt install -y libx11-xcb-dev
  sudo apt install -y libev-dev
  sudo apt install -y libxcb-render-util0-dev
  sudo apt install -y libxcb-image0-dev
  sudo apt install -y libxcb-composite0-dev
  sudo apt install -y libxcb-xinerama0-dev
  sudo python3 -m pip install ninja
  sudo python3 -m pip install meson
elif [ "$OS" = "Gentoo" ]; then
  sudo emerge --update --newuse ninja
  sudo emerge --update --newuse uthash
  sudo emerge --update --newuse libconfig
else
  echo "OS=$OS not setup yet."
fi

mkdir -p "$HOME/projects/github.com/jonaburg"
cd "$HOME/projects/github.com/jonaburg" || exit
git clone https://github.com/jonaburg/picom
cd ./picom || exit
meson --buildtype=release . build
ninja -C build
# To install the binaries in /usr/local/bin (optional)
sudo ninja -C build install

exit 0
