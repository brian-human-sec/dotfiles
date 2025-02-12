#!/bin/sh

if [ -x "$(command -v pacman)" ]; then
  sudo pacman --noconfirm --needed -S fakeroot
  sudo pacman --noconfirm --needed -S base-devel
  mkdir -p "$HOME/projects/archlinux.org/aur/"
  cd "$HOME/projects/archlinux.org/aur/" || exit
  git clone https://aur.archlinux.org/yay.git
  cd yay || exit
  makepkg -si
  cd - || exit
fi

exit 0

# vim: set ft=sh
