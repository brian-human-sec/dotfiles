# gentoo install - last executed on 7/13/2022
download archlinux

https://wiki.gentoo.org/wiki/Handbook:AMD64/Full/Installation

## boot
```
boot archlinux
```

## network configures automatically on gentoo for VirtualBox and most baremetal
```
ip addr show
```

## set root password
```
passwd root
```

## remote ssh login from remote
```
ssh root@192.168.10.103
```

## partition the drive as show below (use dos)
```
cfdisk /dev/sda
cfdisk /dev/vda

parted /dev/sda  mklabel msdos
parted /dev/sda mkpart primary 1 1024
parted /dev/sda set 1 boot on
parted /dev/sda mkpart primary 1024 100%
```

## partition the drive as show below (use gpt)
```
parted /dev/sda mklabel gpt
parted /dev/sda mkpart primary 1 1024
parted /dev/sda mkpart primary 1024 100%
```

## disk layout
```
/dev/sda1	ext2	(bootloader)	1GB
/dev/sda2	ext4	Rest of the disk	Root partition
```

## make the partitions (use gpt)
```
mkfs.fat -F32 /dev/sda1
mkfs.ext4 -j -T small /dev/sda2
```

## make the partitions (use dos)
```
mkfs.ext2 -T small /dev/sda1
mkfs.ext4 -j -T small /dev/sda2
```

## mount the partitions (use gpt)
```
mkdir -p /mnt/gentoo
mount /dev/sda2 /mnt/gentoo
mkdir -p /mnt/gentoo/boot/efi
mount /dev/sda1 /mnt/gentoo/boot/efi
cd /mnt/gentoo
```

## mount the partitions (use dos)
```
mkdir -p /mnt/gentoo
mount /dev/sda2 /mnt/gentoo
mkdir -p /mnt/gentoo/boot
mount /dev/sda1 /mnt/gentoo/boot
cd /mnt/gentoo
```

## download stage3
```
https://mirror.bytemark.co.uk/gentoo/releases/amd64/autobuilds/
curl -Os 'https://mirror.bytemark.co.uk/gentoo/releases/amd64/autobuilds/20220918T170531Z/stage3-amd64-desktop-systemd-20220918T170531Z.tar.xz'
```

## extract stage3 and be sure to verify success
```
tar xvJpf stage3-*.tar.xz --xattrs --numeric-owner
rm stage3-amd64-desktop-systemd-*.tar.xz
```

## generate fstab
```
genfstab -U /mnt/gentoo >> /mnt/gentoo/etc/fstab
```

## erase root and login with systemd
```
cat /mnt/gentoo/etc/shadow | grep root
sed -i -e 's/^root:\*/root:/' /mnt/gentoo/etc/shadow
systemd-nspawn -bD /mnt/gentoo
```

## login (no password)
```
root
```

## set locale systemd
```
cat << EOF >> /etc/locale.gen
en_US.UTF-8 UTF-8
EOF
```

## set locale
```
locale-gen
```

## systemd activities
```
hostnamectl set-hostname "gentoo"
echo "127.0.0.1 gentood.localdomain gentoo" >> /etc/hosts

timedatectl list-timezones
timedatectl set-timezone America/Chicago
timedatectl set-ntp yes
localectl list-locales
localectl set-locale LANG=en_US.utf8
localectl set-keymap us
```

## logout of systemd
```
poweroff
```

## use flags
```
cat << EOF >> /mnt/gentoo/etc/portage/make.conf
MAKEOPTS="-j4"
ACCEPT_LICENSE="*"
EOF
```

## copy the resolv config
```
cp -L /etc/resolv.conf /mnt/gentoo/etc/
```

## mount the devices
```
mount -t proc none /mnt/gentoo/proc
mount --rbind /dev /mnt/gentoo/dev
mount --rbind /sys /mnt/gentoo/sys
modprobe efivarfs
```

## configure the chroot (enter commands individually)
```
chroot /mnt/gentoo /bin/bash
source /etc/profile
export PS1="(chroot) $PS1"
```


## profile select (broken)
```
eselect profile list
eselect profile set 10 (desktop systemd)
```

## set the mirror list (broken)
```
# mirrorselect -i -o >> /etc/portage/make.conf
mkdir -p /mnt/etc/portage/repos.conf
cp -v /usr/share/portage/config/repos.conf /etc/portage/repos.conf/gentoo.conf
```

## user maintenence
```
useradd -m -G users henninb
usermod -aG wheel henninb
passwd henninb
passwd root
```

## run the webrsync (clock needs to be accurate and DNS needs to be functional)
```
emerge-webrsync
eselect news read
```

## install packages
```
emerge sys-kernel/gentoo-sources linux-firmware sys-kernel/genkernel cronie mlocate rsyslog sys-boot/grub:2 sudo
etc-update
```

## edit sudoers
```
cat << EOF >> /etc/sudoers
%wheel ALL=(ALL:ALL) NOPASSWD: ALL
EOF
```

## update system settings
```
systemctl enable rsyslog
systemctl enable cronie
systemctl enable sshd
```

## network setup (enp1s0, eth0)
```
ip link

cat << EOF > /etc/systemd/network/50-dhcp_eth0.network
[Match]
Name=eth0

[Network]
DHCP=yes
EOF

cat << EOF > /etc/systemd/network/50-dhcp_enp1s0.network
[Match]
Name=enp1s0

[Network]
DHCP=yes
EOF

```

## update mtab
```
ln -sf /proc/self/mounts /etc/mtab
```

## probably not needed (not required)
```
vi /etc/initramfs.mounts
/usr
```

## default systemd settings (may not be needed)
```
systemctl preset-all
```

## update dns resolver
```
# ln -snf /run/systemd/resolv.conf /etc/resolv.conf
systemctl enable systemd-resolved.service
```

# build and install the kernel (will take 42 min)
```
eselect kernel list
eselect kernel set 1
genkernel all
genkernel --menuconfig all
genkernel --menuconfig --kernel-config=/usr/src/linux/.config-main --install all
genkernel --kernel-config=/usr/src/linux/.config-main --install all

# grep CONFIG_SCSI_VIRTIO /usr/src/linux/.config
# kernel change only needed if running on a virtual

General Setup
└─> Device Drivers
└─> SCSI device support
└─> SCSI device support
CONFIG_SCSI=y

General Setup
└─> File systems
└─> Virtio Filesystem
CONFIG_VIRTIO_FS=m

General Setup
└─> Device Drivers
└─> Block devices
└─> Virtio block driver
CONFIG_VIRTIO_BLK=y

General Setup
└─> Device Drivers
└─> SCSI device support
└─> SCSI low-level drivers
└─> virtio-scsi support
CONFIG_SCSI_VIRTIO=m

General Setup
└─> Device Drivers
└─> Virtio drivers
└─> PCI support
└─> PCI driver for virtio devices
CONFIG_VIRTIO_PCI=y

General Setup
└─> Device Drivers
└─> Network device support
└─> Virtio network driver
CONFIG_VIRTIO_NET=y
CONFIG_NET_FAILOVER=m
```

## check kernel logs
```
tail -f /var/log/genkernel.log
```

## verify the kernel
```
ls /boot/vmlinuz* /boot/initramfs*
```

## systemd stuff (not sure if needed)
```
systemd-firstboot --prompt --setup-machine-id
systemctl preset-all
systemd-machine-id-setup
```

## grub install (with dos)
```
echo 'GRUB_CMDLINE_LINUX="init=/usr/lib/systemd/systemd"' >> /etc/default/grub
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
```

## grub install (with gpt)
```
echo 'GRUB_CMDLINE_LINUX="init=/usr/lib/systemd/systemd"' >> /etc/default/grub
# grub-install --target=x86_64-efi --boot-directory=/boot/efi --bootloader-id=archlinux /dev/sda
grub-install --target=x86_64-efi --bootloader-id=grub_uefi --efi-directory=/boot/efi
grub-mkconfig -o /boot/grub/grub.cfg
````

## reboot system
```
reboot
```
