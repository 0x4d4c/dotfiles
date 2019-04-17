#!/bin/bash -eu

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

userbin="${HOME}/.local/bin"
if [ -d "${userbin}" -a ! -s "${userbin}" ]; then
  if [ -n "$(ls -A "${userbin}")" ]; then
    mv ${userbin}/* bin/
  fi
  rmdir "${userbin}"
fi

mkdir -p "${HOME}/.cache/greenclip"

_ln autostart ${cfg}/autostart
_ln bin "${userbin}"
_ln dircolors ${cfg}/dircolors
_ln dunst ${cfg}/dunst
_ln git/config ~/.gitconfig
_ln greenclip/config ${cfg}/greenclip.cfg
_ln i3 ${cfg}/i3
_ln polybar ${cfg}/polybar
_ln rofi ${cfg}/rofi
_ln selected_editor ~/.selected_editor
_ln xfce/xfce-terminal/terminalrc ${cfg}/xfce4/terminal/terminalrc
_ln xinitrc ~/.xinitrc
_ln Xresources ~/.Xresources
_ln zsh/zprofile ~/.zprofile
_ln zsh/zshrc ~/.zshrc
_ln zsh/zshrc.d ~/.zshrc.d

