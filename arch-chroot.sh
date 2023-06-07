#!/bin/bash
# arch-chroot without arch
# uses the arch-chroot inside your bootstrapped arch mount

(( ${EUID-} ))&&{ printf '\e[31mx\e[m: %s\n' 'Must be executed as superuser'; exit 1; }

rootFS="$1"

shift
source "$rootFS"/bin/arch-chroot "$rootFS" $*
