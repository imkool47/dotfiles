set -g fish_greeting

if status is-interactive
    starship init fish | source
set -g fish_pager_color_progress $comment
set -g fish_pager_color_prefix $cyan
set -g fish_pager_color_completion $foreground
set -g fish_pager_color_description $comment
set -g fish_pager_color_selected_background --background=$selection
end



# Handy change dir shortcuts
abbr .. 'cd ..'
abbr ... 'cd ../..'
abbr .3 'cd ../../..'
abbr .4 'cd ../../../..'
abbr .5 'cd ../../../../..'

# Always mkdir a path (this doesn't inhibit functionality to make a single dir)
abbr mkdir 'mkdir -p'


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
