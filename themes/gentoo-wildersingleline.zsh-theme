function prompt_char {
	if [ $UID -eq 0 ]; then echo "#" && return;
	fi
        git branch >/dev/null 2>/dev/null && echo '±' && return
        echo '%#'
}

function get_nr_jobs() {
  repeat $(jobs | wc -l) printf '▶'
}

PROMPT='
%(!.%{$fg_bold[red]%}.%{$fg_bold[green]%}%n@)%m %{$fg_bold[blue]%}%(!.%1~.%~)$(git_prompt_info)$(git_commits_ahead)
$(prompt_char)%{$reset_color%} '

RPROMPT='%{$fg_bold[green]%}$(get_nr_jobs)%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{\033[0;36m%}·"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg_bold[blue]%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%}!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%}?"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_COMMITS_AHEAD_PREFIX="%{\033[0;36m%} "
ZSH_THEME_GIT_COMMITS_AHEAD_SUFFIX="↑%{$fg_bold[blue]%}"
