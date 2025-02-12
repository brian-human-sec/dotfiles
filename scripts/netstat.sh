#!/bin/sh

if [ -x "$(command -v netstat)" ]; then
  sudo netstat -tulp
  netstat -na | grep tcp | grep LIST
fi

if [ -x "$(command -v socketstat)" ]; then
  sockstat -4 -l
fi
ss -tulpn4

exit 0

# vim: set ft=sh
