
source "${HOME}/.zgen/zgen.zsh"

if ! zgen saved; then
  echo 'Generating zgen config...'
  zgen prezto
  zgen prezto archive
  zgen prezto git
  zgen prezto gpg
  zgen prezto history-substring-search

  zgen load zsh-users/zsh-completions

  zgen load chrissicool/zsh-256color

  zgen save
fi

zstyle ':prezto:*:*' color 'yes'

# == dircolors ==
#
eval $(dircolors ${HOME}/.config/dircolors/config)
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"

# == aliases ==
#
for f in ${HOME}/.zshrc.d/aliases.d/*.zsh; do
  source "${f}"
done

