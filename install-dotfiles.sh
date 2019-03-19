#!/bin/bash -eu

dots="$(dirname $(readlink -e $0))"
cfg="${HOME}/.config"

function _ln() {
  ln -snf "${dots}/$1" "$2"
}


mkdir -p ~/.config
mkdir -p ~/.local/bin

_ln autostart ${cfg}/autostart
_ln dircolors ${cfg}/dircolors
_ln git/config ~/.gitconfig
_ln i3 ${cfg}/i3
_ln rofi ${cfg}/rofi
_ln xinitrc ~/.xinitrc
_ln zprofile ~/.zprofile

