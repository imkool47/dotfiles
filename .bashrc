#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

export PATH=$PATH:/home/ooximkool/.spicetify
export THEFUCK_SHELL=bash
export THEFUCK_SHELL=bash
export THEFUCK_SHELL=bash
export THEFUCK_SHELL=bash
export THEFUCK_SHELL=bash

eval "$(thefuck --alias)"
export THEFUCK_SHELL=bash

eval "$(zoxide init bash)"
# Set up fzf key bindings and fuzzy completion
eval "$(fzf --bash)"

export FZF_DEFAULT_OPTS="
  --style full \
  --border --padding 1,2 \
  --border-label '' \
  --input-label ' Input ' --header-label ' File Type ' \
  --preview 'bat --style=numbers --color=always {} 2>/dev/null || cat {} 2>/dev/null' \
  --bind 'focus:transform-border-label:[[ -n {} ]] && echo \"Previewing [$(basename {})]\" || echo \"Select File\"' \
  --bind 'result:transform-list-label:
      if [[ -z \$FZF_QUERY ]]; then
        echo \" \$FZF_MATCH_COUNT items \"
      else
        echo \" \$FZF_MATCH_COUNT matches for [\$FZF_QUERY] \"
      fi
      ' \
  --bind 'focus:+transform-header:file --brief {} || echo \"No file selected\"' \
  --bind 'ctrl-r:change-list-label( Reloading the list )+reload($FZF_DEFAULT_COMMAND)' \
  --color 'border:#aaaaaa,label:#cccccc' \
  --color 'preview-border:#9999cc,preview-label:#ccccff' \
  --color 'list-border:#669966,list-label:#99cc99' \
  --color 'input-border:#996666,input-label:#ffcccc' \
  --color 'header-border:#6699cc,header-label:#99ccff'
"

fzf_open_multiple() {
  local files
  files=$(fzf --multi --preview 'bat --style=numbers --color=always {} 2>/dev/null || cat {} 2>/dev/null') || return

  if [[ -n "$files" ]]; then
    local count=$(echo "$files" | wc -l)

    if [[ $count -eq 1 ]]; then
      nvim $files
    elif [[ $count -eq 2 ]]; then
      nvim -c "edit $(echo "$files" | sed -n 1p)" \
           -c "vsplit $(echo "$files" | sed -n 2p)"
    elif [[ $count -eq 3 ]]; then
      nvim -c "edit $(echo "$files" | sed -n 1p)" \
           -c "vsplit $(echo "$files" | sed -n 2p)" \
           -c "split $(echo "$files" | sed -n 3p)" \
           -c "set winhighlight=Normal:Normal,WinSeparator:WinSeparator"
    elif [[ $count -eq 4 ]]; then
      nvim -c "edit $(echo "$files" | sed -n 1p)" \
           -c "vsplit $(echo "$files" | sed -n 2p)" \
           -c "split $(echo "$files" | sed -n 3p)" \
           -c "split $(echo "$files" | sed -n 4p)" \
           -c "set winhighlight=Normal:Normal,WinSeparator:WinSeparator"
    fi
  fi
}

# Bind to Ctrl-o
bind -x '"\C-o": fzf_open_multiple'

# Search files using fzf and open in nvim
fzfn() {
  local file
  file=$(fzf --style full --border --preview 'bat --color=always {}' --exit-0)
  if [[ -n $file ]]; then
    nvim "$file"
  fi
}

#Alise (same issue as fish)
#alias fzf='fzf --style full --border --preview "bat --color=always {}" --exit-0 | xargs -r nvim'
