#!/bin/sh

# github.com/dbbolton
#
# run this after configuration to build kernel debs
MAKEFLAGS=''
appendage='-custom'
timestamp=`date +"%Y%m%d"`
make-kpkg clean
time fakeroot make-kpkg         \
 --append-to-version $appendage  \
 --revision $timestamp \
 --initrd                       \
 kernel_image kernel_headers

