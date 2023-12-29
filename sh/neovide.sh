#!/usr/bin/env bash

KATALOG="$(dirname $(readlink -m $0))"
SKRYPT="$(basename $(readlink -m $0))"
FULL_FILE_NAME=$KATALOG/$SKRYPT
DATA=$(date +%F-%T | tr : -)

[[ -f "$HOME/.config/vars" ]] && . "$HOME/.config/vars"

LC_ALL=en_US.UTF-8 NVIM_APPNAME=nvim-qfjz ~/bin/neovide --x11-wm-class neovide ~/Notes/
