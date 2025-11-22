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
            exec startx
        case W S
            if command -v uwsm 1>/dev/null && uwsm check may-start
                if test $OPT = S
                    uwsm select
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
    set -g fish_greeting ""
    fish_config prompt choose arrow

    if command -v podman &>/dev/null
        alias docker podman
    end

    if command -v nvim &>/dev/null
        alias vim nvim
        alias vi /usr/bin/vim
    end

    if command -v podman &>/dev/null
        set -gx DOCKER_HOST "unix://$XDG_RUNTIME_DIR/podman/podman.sock"
    end
end
