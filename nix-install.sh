#!/bin/sh

sudo eopkg install -y rsync

sh <(curl -L https://nixos.org/nix/install) --daemon

exit 0

example
https://github.com/endofunky/nix-config/tree/4b0332656f835f6b2fcbcfa27b4ea60576f0b7e3
