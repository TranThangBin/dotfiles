set -g fish_greeting ""
set -g fish_key_bindings fish_vi_key_bindings

if status is-login && test "$(tty)" = /dev/tty1
    echo "- [X]11"
    echo "- [W]ayland"
    echo "- [S]elect wayland environment"
    echo "- [R]eboot"
    echo "- reboot to [F]irmware interface"
    echo "- [P]oweroff"
    echo "- [Enter] tty"
    read -p "set_color cyan; echo -n 'Pick your option '; set_color green; echo -n '> '; set_color normal" -n 1 OPT

    switch "$OPT"
        case X
            if command -vq startx
                set -gx XINITRC "$HOME/.config/xinit/xinitrc"
                exec startx
            end
        case W S
            if command -vq uwsm && command uwsm check may-start
                if test $OPT = S
                    command uwsm select
                end
                exec uwsm start default
            end
        case R
            systemctl reboot
        case P
            systemctl poweroff
        case "*"
            echo "Entering tty"
    end
end

if status is-interactive
    fish_config prompt choose arrow

    if command -vq podman
        set -gx DOCKER_HOST "unix://$XDG_RUNTIME_DIR/podman/podman.sock"
    end

    if command -vq nvim
        alias vim nvim
        alias vi /usr/bin/vim
        set -gx EDITOR nvim
    else
        set -gx EDITOR vim
    end

    abbr dbx distrobox
    abbr sc systemctl
    abbr scu "systemctl --user"
end
