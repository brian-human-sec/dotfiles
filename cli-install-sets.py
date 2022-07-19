#!/usr/bin/env python

import csv
import glob
import os

def get_list(fname):
    rows = []
    rows1 = set()
    with open(fname, 'r') as file:
      contents = file.read()
      list = contents.strip('\n').split(' ')
      for item in list:
        rows.append(item)
        rows1.add(item)
    file.close()
    return rows1

def print_set(sname):
    for row1 in sname:
        print((row1))

mintlinux = get_list(os.environ["HOME"] + '/tmp/cli/mintlinux')
archlinux = get_list(os.environ["HOME"] + '/tmp/cli/archlinux')
raspi = get_list(os.environ["HOME"] + '/tmp/cli/raspi')
gentoo = get_list(os.environ["HOME"] + '/tmp/cli/gentoo')
centos = get_list(os.environ["HOME"] + '/tmp/cli/centos')
freebsd = get_list(os.environ["HOME"] + '/tmp/cli/freebsd')
ubuntu = get_list(os.environ["HOME"] + '/tmp/cli/ubuntu')
void = get_list(os.environ["HOME"] + '/tmp/cli/void')

ubuntu_raspi = ubuntu.difference(raspi)
ubuntu_mintlinux = ubuntu.difference(mintlinux)
mintlinux_ubuntu = mintlinux.difference(ubuntu)
mintlinux_raspi = mintlinux.difference(raspi)
raspi_mintlinux = raspi.difference(mintlinux)
raspi_ubuntu = raspi.difference(ubuntu)
ubuntu_archlinux = ubuntu.difference(archlinux)
archlinux_ubuntu = archlinux.difference(ubuntu)

print('add to mintlinux ' + str(ubuntu_mintlinux))
print('add to raspi ' + str(ubuntu_raspi))
print('add to ubuntu ' + str(mintlinux_ubuntu))
print('add to ubuntu ' + str(archlinux_ubuntu))
print('add to raspi ' + str(mintlinux_raspi))
print('add to archlinux ' + str(ubuntu_archlinux))
