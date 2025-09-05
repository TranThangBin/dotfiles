[[ -f "$ZDOTDIR/.ohmyzsh" ]] && source "$ZDOTDIR/.ohmyzsh"
[[ -f "$ZDOTDIR/.alias" ]] && source "$ZDOTDIR/.alias"

setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
export HIST_IGNORE_PATTERN="clear|sudo *"

bindkey '^ ' autosuggest-accept

[[ -f "/usr/bin/fzf" ]] && eval "$(/usr/bin/fzf --zsh)"
if [[ -f "/usr/bin/zoxide" ]]; then
    eval "$(/usr/bin/zoxide init zsh)"
else
    eval "$(zoxide init zsh)"
fi

source $ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

if [[ -z $TMUX ]]; then
    fastfetch
fi
