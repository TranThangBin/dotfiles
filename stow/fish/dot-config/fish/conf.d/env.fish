if not set -q DISTROBOX_HOME
    set -gx DISTROBOX_HOME $HOME/distrobox
end

if not set -q DOTFILES_DIR
    set -gx DOTFILES_DIR $HOME/dotfiles
end

if not set -q STOW_DIR
    set -gx STOW_DIR $DOTFILES_DIR/stow
end

if not set -q EDITOR
    if command -v nvim &>/dev/null
        set -gx EDITOR nvim
    else
        set -gx EDITOR vim
    end
end
