if path is -f "$HOME/.config/uwsm/env" || path is -l "$HOME/.config/uwsm/env"
    sed "s/^#//" "$HOME/.config/uwsm/env" | source
end
