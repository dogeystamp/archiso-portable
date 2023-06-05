#!/bin/bash

mnt="$1"; shift
systemd-machine-id-setup

pacman-key --init; pacman-key --populate
pacman -Syu --needed --noconfirm "$@"&& printf '\e[32m>\e[m: %s\n' 'Updated & installed packages'
