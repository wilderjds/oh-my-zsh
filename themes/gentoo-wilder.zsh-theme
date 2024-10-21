#! /bin/zsh

jobs_marker=(         )

# Solarized
solarized_base03=$'\e[1;30m'
solarized_base02=$'\e[0;30m'
solarized_base01=$'\e[1;32m'
solarized_base00=$'\e[1;33m'
solarized_base0=$'\e[1;34m'
solarized_base1=$'\e[1;36m'
solarized_base2=$'\e[0;37m'
solarized_base3=$'\e[1;37m'

solarized_yellow=$'\e[0;33m'
solarized_orange=$'\e[1;31m'
solarized_red=$'\e[0;31m'
solarized_magenta=$'\e[0;35m'
solarized_violet=$'\e[1;35m'
solarized_blue=$'\e[0;34m'
solarized_cyan=$'\e[0;36m'
solarized_green=$'\e[0;32m'

dir_tint=$solarized_blue
jobs_tint=$solarized_green
root_tint=$solarized_magenta

function prompt_char {
	if [ $UID -eq 0 ]; then echo "%{$root_tint%}#%{$reset_color%}" && return;
	fi
    is_curr_dir_remote || {git branch >/dev/null 2>/dev/null && echo '±' && return}
    echo '%#'
}

function is_curr_dir_remote {
    [[ $(pwd) =~ .*nextcloud.* ]] # ||     [[ $(pwd) =~ .*dropbox.* ]]
}

function git_stuff {
    is_curr_dir_remote || echo -n $(git_prompt_info)$(git_commits_ahead)$(git_commits_behind)
}

# newline ⎡⎧⎛⎢
return_code_vertical_top="%(?.%{$reset_color%}.%{$solarized_magenta%})⎥%{$reset_color%} "
return_code_vertical="%(?.%{$reset_color%}.%{$solarized_magenta%})⎥%{$reset_color%} "

PROMPT="
$return_code_vertical_top"

# add username only from remote
[[ "$SSH_CONNECTION" != '' ]] && PROMPT+=$'%(!.%{\e[0;34m%}%}.%{\e[0;32m%}%}%n@)%m '

PROMPT+=$'%{$dir_tint%}%(!.%1~.%~)%{$reset_color%}$(git_stuff)
${return_code_vertical}$(prompt_char)%{$reset_color%} '

RPROMPT=$'%{$jobs_tint%}$jobs_marker[${(%):-%j}]%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{\033[1;32m%} · %{\033[0;36m%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg_bold[blue]%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{\e[0;35m%} !"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%}?"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_COMMITS_AHEAD_PREFIX="%{\033[0;36m%} "
ZSH_THEME_GIT_COMMITS_AHEAD_SUFFIX="↑%{$fg_bold[blue]%}"
ZSH_THEME_GIT_COMMITS_BEHIND_PREFIX="%{\033[0;36m%} "
ZSH_THEME_GIT_COMMITS_BEHIND_SUFFIX="↓%{$fg_bold[blue]%}"
