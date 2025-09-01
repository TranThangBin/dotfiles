[[ -f  "$ZDOTDIR/.ohmyzsh" ]] && source "$ZDOTDIR/.ohmyzsh"
[[ -f  "$ZDOTDIR/.alias" ]] && source "$ZDOTDIR/.alias"

[[ -z $TMUX ]] && fastfetch

setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
export HIST_IGNORE_PATTERN="clear|sudo *"

bindkey '^ ' autosuggest-accept

[[ -f "/usr/bin/fzf" ]] && eval "$(/usr/bin/fzf --zsh)"
[[ -f "/usr/bin/zoxide" ]] && eval "$(/usr/bin/zoxide init zsh)"

source $ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
