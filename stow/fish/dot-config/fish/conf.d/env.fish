if not set -q DISTROBOX_HOME
    set -x DISTROBOX_HOME $HOME/.local/share/distrobox/home
end

if not set -q DOTFILES_DIR
    set -x DOTFILES_DIR $HOME/dotfiles
end

if not set -q STOW_DIR
    set -x STOW_DIR $DOTFILES_DIR/stow
end

if not set -q EDITOR
    if command -v nvim &>/dev/null
        set -x EDITOR nvim
    else
        set -x EDITOR vim
    end
end
