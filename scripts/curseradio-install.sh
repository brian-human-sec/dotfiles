#!/bin/sh

cd projects || exit
git clone https://github.com/chronitis/curseradio.git
cd curseradio || exit
sudo python setup.py install

exit 0

# vim: set ft=sh:
