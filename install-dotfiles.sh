#!/bin/bash -u

dots="$(dirname $(readlink -e $0))"
cfg="${HOME}/.config"

function _ln() {
  ln -snf "${dots}/$1" "$2"
}

if [ ! -d "${HOME}/.zgen" ]; then
  git clone  https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"
else
  zsh -c "source ${HOME}/.zgen/zgen.zsh && zgen selfupdate"
fi

mkdir -p ~/.config
mkdir -p ~/.local/bin

_ln autostart ${cfg}/autostart
_ln dircolors ${cfg}/dircolors
_ln git/config ~/.gitconfig
_ln i3 ${cfg}/i3
_ln rofi ${cfg}/rofi
_ln xfce/xfce-terminal/terminalrc ${cfg}/xfce4/terminal/terminalrc
_ln xinitrc ~/.xinitrc
_ln Xresources ~/.Xresources
_ln zsh/zprofile ~/.zprofile
_ln zsh/zshrc ~/.zshrc
_ln zsh/zshrc.d ~/.zshrc.d

