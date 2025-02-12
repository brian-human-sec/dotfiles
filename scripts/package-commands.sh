#!/bin/sh

if [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  echo list all packages
  echo apt list --installed
elif [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  echo list all packages
  echo pacman -Q
  echo sudo pacman -S nvidia-utils --overwrite \'*\'
  echo sudo pacman -R package_name
  echo sudo pacman -Rsnc package_name
  echo pacman -Ss package_name
elif [ "$OS" = "void" ]; then
  echo export SSL_NO_VERIFY_PEER=1
  echo sudo xbps-install -Suy
  echo sudo xbps-install -u xbps
  echo sudo xbps-install package_name
  echo xbps-query -Rs package_name
elif [ "$OS" = "Fedora" ]; then
  echo dnf repoquery -l xorg-x11-server-Xorg
elif [ "$OS" = "Solus" ]; then
  echo sudo eopkg upgrade -y
  echo sudo eopkg install -y package_name
  echo sudo eopkg remove -y package_name
elif [ "$OS" = "Gentoo" ]; then
  echo list all packages
  echo emerge world -ep
  echo sudo emerge --update --newuse package_name
  echo sudo emerge --deselect package_name # remove from world
  echo sudo emerge -C package_name # remove and disregard deped
  echo sudo emerge --pretend --depclean
  echo sudo emerge -cav package_name # verify depends
  echo sudo emerge -pv dev-lang/python-exec # pretend
  echo sudo emerge "=net-misc/spice-gtk-0.39-r2" # pin specific
  echo cat /var/lib/portage/world  # lsit installed packages
else
  echo "$OS is not yet implemented."
  exit 1
fi

echo nodejs
echo npm ls --global packae_name
echo npm rm --global package_name

exit 0


# vim: set ft=sh
