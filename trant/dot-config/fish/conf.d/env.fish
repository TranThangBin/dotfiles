if not set -q DISTROBOX_HOME
    set -g DISTROBOX_HOME $HOME/.local/share/distrobox/home
end

if not set -q DOTFILES_DIR
    set -g DOTFILES_DIR $HOME/dotfiles
end

if not set -q EDITOR
    if command -v nvim &>/dev/null
        set -g EDITOR nvim
    else
        set -g EDITOR vim
    end
end
