if [ $UID -eq 0 ]; then NCOLOR="red"; else NCOLOR="green"; fi
local return_code="%{$fg[red]%}%?%{$reset_color%}"

# git_status="($(git rev-parse --abbrev-ref HEAD 2>/dev/null))"
git_status=""
#$(git_prompt_info) \

PROMPT='%{$fg[$NCOLOR]%}%n%{$reset_color%}@%{$fg[cyan]%}%m\
%{$reset_color%}:%{$fg[magenta]%}%~\
%{$fg[yellow]%}$git_status%{$reset_color%} \
%{$fg[red]%}%(!.#.%?)%{$reset_color%} $ '
PROMPT2='%{$fg[red]%}\ %{$reset_color%}'
#RPS1='${return_code}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}("
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg[yellow]%})%{$reset_color%}"
