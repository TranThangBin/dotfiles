[[ -f "$ZDOTDIR/.oh-my-zsh" ]] && source "$ZDOTDIR/.oh-my-zsh"
[[ -f "$ZDOTDIR/.alias" ]] && source "$ZDOTDIR/.alias"

setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
export HIST_IGNORE_PATTERN="clear|sudo *"

bindkey '^ ' autosuggest-accept

[[ -f "/usr/bin/fzf" ]] && eval "$(/usr/bin/fzf --zsh)"
command -v zoxide &>/dev/null && eval "$(zoxide init zsh)"

source $ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

if [[ -z $TMUX ]]; then
    command -v fastfetch &>/dev/null && fastfetch
fi
