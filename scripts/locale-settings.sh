#!/bin/sh

cat > locale.gen << EOF
en_US.UTF-8 UTF-8
EOF

if [ "$OS" = "Gentoo" ]; then
  sudo mv -v locale.gen /etc/locale.gen
  sudo locale-gen
  echo sudo eselect locale set 4
  sudo eselect locale list
elif [ "$OS" = "void" ]; then
  sudo xbps-reconfigure -f glibc-locales
  sudo xbps-reconfigure -f glibc-locales
  locale -a
else
  echo "OS is not configured."
fi

export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_NUMERIC=en_US.UTF-8
export LC_TIME=en_US.UTF-8
export LC_COLLATE=C
export LC_MONETARY=en_US.UTF-8
export LC_MESSAGES=en_US.UTF-8
export LC_PAPER=en_US.UTF-8
export LC_NAME=en_US.UTF-8
export LC_ADDRESS=en_US.UTF-8
export LC_TELEPHONE=en_US.UTF-8
export LC_MEASUREMENT=en_US.UTF-8
export LC_IDENTIFICATION=en_US.UTF-8

exit 0

# vim: set ft=sh:
