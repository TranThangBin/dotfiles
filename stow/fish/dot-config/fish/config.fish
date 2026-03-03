set -g fish_greeting ""
set -g fish_key_bindings fish_vi_key_bindings

if status is-login; and test "$(tty)" = /dev/tty1
    echo "- [W]ayland"
    echo "- [S]elect wayland environment"
    echo "- [R]eboot"
    echo "- reboot to [F]irmware interface"
    echo "- [P]oweroff"
    echo "- [Enter] tty"
    read -p "set_color cyan; echo -n 'Pick your option '; set_color green; echo -n '> '; set_color normal" -n 1 OPT

    switch "$OPT"
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

    if command -q podman
        test -z "$XDG_RUNTIME_DIR"; and set -l XDG_RUNTIME_DIR "/run/user/$(id -ru)"
        set -gx DOCKER_HOST "unix://$XDG_RUNTIME_DIR/podman/podman.sock"
    end

    if command -q nvim
        alias vim "command nvim"
        alias vi "command -q vim; and command vim"
        set -gx EDITOR (command -s nvim)
    else if command -q vim
        set -gx EDITOR (command -s vim)
    end

    abbr dbx -- distrobox
    abbr sc -- systemctl
    abbr scu -- systemctl --user
end
