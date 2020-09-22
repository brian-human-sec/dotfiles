#!/bin/sh

if [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ]; then
  wget "https://github.com/browsh-org/browsh/releases/download/v1.6.4/browsh_1.6.4_linux_amd64.deb"
  sudo dpkg -i browsh_1.6.4_linux_amd64.deb
elif [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ]; then
  cd projects || exit
  git clone https://archlinux.org/yay.git
  git clone https://archlinux.org/browsh-bin.git
else
  echo "$OS is not yet implemented."
  exit 1
fi

exit 0
