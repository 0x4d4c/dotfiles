
source "${HOME}/.zgen/zgen.zsh"

if ! zgen saved; then
  echo 'Generating zgen config...'
  zgen prezto
  zgen prezto archive
  zgen prezto git
  zgen prezto gpg
  zgen prezto history-substring-search

  zgen load zsh-users/zsh-completions

  zgen save
fi
