# grub info

## fix for screen resolution in the console on nvidia systems in linux mint
```
$ sudo vi /etc/default/grub

# grub changes for Nvidia with respect to screen resolution
# run the following after the updates to this file
# sudo update-grub
GRUB_GFXMODE=1920x1080x24
# Hack to force higher framebuffer resolution
GRUB_GFXPAYLOAD_LINUX=1920x1080
```

## grub visual tool
sudo apt install grub-customizer

## fix for proxmox
```
$ sudo vi /etc/default/grub
GRUB_CMDLINE_LINUX="intel_iommu=on"
$ sudo update-grub
$ sudo reboot
```

## manual boot
grub> ls

(hd0) (hd0,msdos2) (hd0,msdos1)

grub> root=(hd0,msdos1)

Now we can tell it to load or kernel image. (Just note that you must put in the full filename of the image.
grub> linux /vmlinuz root=/dev/sda2

tell the kernel where it can find it's initialization RAM disk (initrd)
grub> initrd /initrd.img
grub> boot



root=hd0,1
linux /boot/kernel-3.2.12-gentoo root=/dev/sda3
}

lsblk -f
├─sda1 ext2     1.0                          93854486-ecb9-4f51-82ea-16363d4c921e
└─sda2 ext4     1.0                          947dd6e2-9d62-42c3-bc4c-57415b8c6403
menuentry "Debian GNU/Linux, linux 2.6.26-2-xen-686" {
    set root=(hd0,1)
    search --fs-uuid --set 3765189f-fdaf-48d4-a04b-d696e6cffdbd
    linux    /boot/vmlinuz-2.6.26-2-xen-686 root=UUID=3765189f-fdaf-48d4-a04b-d696e6cffdbd ro console=ttyS0,115200 console=tty1 vga=792
    initrd    /boot/initrd.img-2.6.26-2-xen-686
}
