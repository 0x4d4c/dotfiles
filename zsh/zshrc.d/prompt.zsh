pmodload 'helper'

VIRTUAL_ENV_DISABLE_PROMPT=true

autoload -U colors && colors

setopt prompt_subst

function _prompt_segment_current_directory() {
  prompt_info_line+='%{%K{012}%}%{%F{black}%} %2~ '
}

function _prompt_segment_status_code() {
  local rv=$1
  if [ ${rv} -ne 0 ]; then
    prompt_info_line+="%{%K{red}%}%{%F{black}%} ✘ ${rv} "
  fi
}

function _prompt_segment_virtualenv() {
  if [ -n "${VIRTUAL_ENV}" ]; then
    prompt_info_line+="%{%K{green}%}%{%F{black}%}  $(basename ${VIRTUAL_ENV}) "
  fi
}

function _prompt_segment_git() {
  if (( $+functions[git-info] )); then
    git_status=git-info
  fi
  if ${git_status}; then
    local git_root="$(command git rev-parse --show-toplevel 2> /dev/null)"
    if [[ -n "${git_root}" ]]; then
      git_root="$(basename ${git_root})"
    fi
    prompt_info_line+="%{%K{yellow}%}%{%F{black}%} ${git_root} ${(e)git_info[prompt]}"
    echo $git_info[status]
  fi
}

function _prompt_segment_clock() {
  prompt_info_line+="%K{015}%F{black} $(date +%T)"
}

function _prompt_filler() {
  local space_req_after_filler="$1"
  local cur_width="${(S)prompt_info_line//\%\{*\%\}}"
  cur_width="${#${(%)cur_width}}"
  filler="$(( ${COLUMNS} - ${cur_width} - ${space_req_after_filler}))"
  filler="${(l:${filler}:::)}"
  prompt_info_line+="%{%K{008}%}%{%F{009}%}${filler} "
}

function _finalize_prompt_info_line() {
  prompt_info_line+=' %{%k%}%{%f%}'
}

function _build_prompt_info_line() {
  retval=$?
  prompt_info_line=''
  _prompt_segment_current_directory
  _prompt_segment_status_code ${retval}
  _prompt_segment_virtualenv
  _prompt_segment_git
  _prompt_filler 12
  _prompt_segment_clock
  _finalize_prompt_info_line
}


function prompt_setup() {
  setopt LOCAL_OPTIONS
  unsetopt XTRACE KSH_ARRAYS
  prompt_opts=(cr percent subst)

  autoload -Uz add-zsh-hook
  add-zsh-hook precmd _build_prompt_info_line

  zstyle ':prezto:module:editor:info:completing' format '%B%F{red}...%f%b'
  zstyle ':prezto:module:git:info' verbose 'yes'
  zstyle ':prezto:module:git:info:branch' format ' %b'
  zstyle ':prezto:module:git:info:ahead' format ' '
  zstyle ':prezto:module:git:info:behind' format ' '
  zstyle ':prezto:module:git:info:dirty' format ' '
  zstyle ':prezto:module:git:info:untracked' format ' '
  zstyle ':prezto:module:git:info:modified' format ' '
  zstyle ':prezto:module:git:info:deleted' format ' '
  zstyle ':prezto:module:git:info:renamed' format ' '
  zstyle ':prezto:module:git:info:stashed' format ' '
  zstyle ':prezto:module:git:info:keys' format 'prompt' '%b %A%B%S%u$(coalesce "%d" "%m" "%r") '

  PROMPT='
${prompt_info_line}
 ➜ '
  SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '
}

prompt_setup "$@"

