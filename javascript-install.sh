#!/bin/sh

#sudo apt install -y yarn
# unset NVM_DIR

# if [ ! -f "$HOME/.nvm" ]; then
#   git clone https://github.com/nvm-sh/nvm.git $HOME/.nvm
# fi

if [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Debian GNU/Linux" ]; then
  sudo apt install -y curl
  # curl -fsSL https://deb.nodesource.com/setup_14.x | sudo -E bash -
  echo sudo apt install -y nodejs
elif [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  echo sudo pacman --noconfirm --needed -S nodejs
  echo sudo pacman --noconfirm --needed -S npm
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  echo sudo zypper install -y nodejs
elif [ "$OS" = "void" ]; then
  echo
elif [ "$OS" = "Gentoo" ]; then
  echo sudo emerge  --update --newuse nodejs
elif [ "$OS" = "Solus" ]; then
  echo sudo eopkg install nodejs
elif [ "$OS" = "CentOS Linux" ]; then
  echo centos
elif [ "$OS" = "FreeBSD" ]; then
  echo sudo pkg install -y gcc python27 gmake
  echo sudo pkg install -y npm
else
  echo "$OS is not yet implemented."
  exit 1
fi

if [ -x "$(command -v nvm)" ]; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | zsh
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
  if ! nvm install 16.15.1; then
    echo nvm failed.
    exit 1
  fi
fi

if [ -x "$(command -v node)" ]; then
  if ! nvm install 16.15.1; then
    echo nvm failed.
    exit 1
  fi
fi

exit 0

# vim: set ft=sh
