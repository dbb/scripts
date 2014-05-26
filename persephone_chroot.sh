#!/bin/sh

dir=/mnt/chroot
mkdir -pv $dir

swapon /dev/sda5

mount /dev/sda2 $dir
mount /dev/sda1 $dir/boot
mount /dev/sda3 $dir/home
mount /dev/sda6 $dir/var
mount /dev/sda7 $dir/data

mount -o bind /proc    $dir/proc
mount -o bind /dev     $dir/dev
mount -o bind /dev/pts $dir/dev/pts
mount -o bind /sys     $dir/sys  

chroot $dir /bin/zsh4
