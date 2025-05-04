set -g fish_greeting

if status is-interactive
    starship init fish | source
set -g fish_pager_color_progress $comment
set -g fish_pager_color_prefix $cyan
set -g fish_pager_color_completion $foreground
set -g fish_pager_color_description $comment
set -g fish_pager_color_selected_background --background=$selection
end

set --export BROWSER "/usr/bin/zen-browser"
set MOZ_ENABLE_WAYLAND "1"
set PYENV_ROOT "$HOME/.pyenv"
 set PATH "$PYENV_ROOT/bin:$PATH"
 set XDG_CURRENT_DESKTOP "Hyprland"
set PERCENTAGE "$(echo "$upower_out" | grep 'percentage:' | grep -oe '[0-9]*%')"
eval "$(pyenv init -)"
fastfetch
starship init fish | source


function sudo_last
    eval sudo (history | head -n1)
end

abbr -a !! --position anywhere --function sudo_last

thefuck --alias | source
zoxide init fish | source
# Set up fzf key bindings
fzf --fish | source

set -x FZF_DEFAULT_OPTS "
  --style full
  --border --padding 1,2
  --border-label ''
  --input-label ' Input ' --header-label ' File Type '
  --preview 'bat --style=numbers --color=always {} 2>/dev/null || cat {} 2>/dev/null'
  --bind 'focus:transform-border-label:[[ -n {} ]] && echo \"Previewing [$(basename {})]\" || echo \"Select File\"'
  --bind 'result:transform-list-label:
      if [[ -z \$FZF_QUERY ]]; then
        echo \" \$FZF_MATCH_COUNT items \"
      else
        echo \" \$FZF_MATCH_COUNT matches for [\$FZF_QUERY] \"
      fi
      '
  --bind 'focus:+transform-header:file --brief {} || echo \"No file selected\"'
  --bind 'ctrl-r:change-list-label( Reloading the list )+reload($FZF_DEFAULT_COMMAND)'
  --color 'border:#aaaaaa,label:#cccccc'
  --color 'preview-border:#9999cc,preview-label:#ccccff'
  --color 'list-border:#669966,list-label:#99cc99'
  --color 'input-border:#996666,input-label:#ffcccc'
  --color 'header-border:#6699cc,header-label:#99ccff'
"

function fzf_open_multiple
  set files (fzf --multi --preview 'bat --style=numbers --color=always {} 2>/dev/null || cat {} 2>/dev/null')

  if test (count $files) -gt 0
    switch (count $files)
      case 1
        nvim $files[1]
      case 2
        nvim -c "edit $files[1]" -c "vsplit $files[2]"
      case 3
        nvim -c "edit $files[1]" \
             -c "vsplit $files[2]" \
             -c "split $files[3]" \
             -c "set winhighlight=Normal:Normal,WinSeparator:WinSeparator"
      case 4
        nvim -c "edit $files[1]" \
             -c "vsplit $files[2]" \
             -c "split $files[3]" \
             -c "split $files[4]" \
             -c "set winhighlight=Normal:Normal,WinSeparator:WinSeparator"
    end
  end
end

# Bind to Ctrl-o
bind \co fzf_open_multiple

# Search files using fzf and open in nvim
function fzfn
  set file (fzf --style full --border --preview 'bat --color=always {}' --exit-0)
  if test -n "$file"
    nvim "$file"
  end
end

#Alise for fzf to open in nvim (causing an issue with multiple file opening in tmux)
# alias fzf="fzf --style full --border --preview 'bat --color=always {}' --exit-0 | xargs -r nvim"

# function cava
#     kitty --class=CavaTerm cava
# end
source ~/.config/fish/aliases.fish
