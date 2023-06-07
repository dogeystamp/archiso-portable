#!/bin/bash

mnt="$1"; shift
systemd-machine-id-setup

pacman-key --init; pacman-key --populate
if [ -f /etc/pacman.chroot.conf ]; then
    PACMAN_CONF="/etc/pacman.chroot.conf"
else
    PACMAN_CONF="/etc/pacman.conf"
fi
pacman --config "$PACMAN_CONF" -Syu --needed --noconfirm "$@"&& printf '\e[32m>\e[m: %s\n' 'Updated & installed packages'
