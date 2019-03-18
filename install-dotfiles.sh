#!/bin/sh -eu

dots="$(dirname $(readlink -e $0))"

function _ln() {
  ln -snf "${dots}/$1" "$2"
}


mkdir -p ~/.config
mkdir -p ~/.local/bin


