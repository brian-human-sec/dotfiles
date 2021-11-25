#!/bin/sh

iso_file=FreeBSD-13.0-RELEASE-amd64-dvd1.iso

virsh shutdown guest-freebsd
virsh undefine guest-freebsd

sudo rm -rf /var/lib/libvirt/images/guest-freebsd.qcow2

if [ ! -f "/var/lib/libvirt/boot/${iso_file}" ]; then
  scp "pi:/home/pi/downloads/${iso_file}" .
  sudo mv "${iso_file}" /var/lib/libvirt/boot/
fi

sudo virt-install \
--virt-type=kvm \
--name guest-freebsd \
--memory=2048,maxmemory=2048 \
--vcpus=1,maxvcpus=2 \
--os-variant=freebsd10.0 \
--virt-type=kvm \
--hvm \
--cdrom=/var/lib/libvirt/boot/${iso_file} \
--network=bridge=virbr0,model=virtio \
--graphics vnc \
--disk path=/var/lib/libvirt/images/guest-freebsd.qcow2,size=40,bus=virtio,format=qcow2

exit 0
