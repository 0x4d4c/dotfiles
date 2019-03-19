#!/bin/bash -eu

dots="$(dirname $(readlink -e $0))"

function _ln() {
  ln -snf "${dots}/$1" "$2"
}


mkdir -p ~/.config
mkdir -p ~/.local/bin

_ln dircolors ~/.config/dircolors
_ln i3 ~/.config/i3
_ln rofi ~/.config/rofi
_ln xinitrc ~/.xinitrc
_ln zprofile ~/.zprofile

