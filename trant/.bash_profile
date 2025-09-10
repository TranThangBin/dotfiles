_login() {
    if [ "$(tty)" != "/dev/tty1" ]; then
        return 0
    fi

    echo "What type of session would you like to enter"
    echo "- [X]11"
    echo "- [W]ayland"
    echo "- [*] Others"
    printf "> "
    read -rn 1 session

    if [ "$session" = "X" ]; then
        exec startx
    elif [ "$session" = "W" ]; then
        if uwsm check may-start && uwsm select; then
            exec uwsm start default
        fi
    fi
}

_login
unset -f _login
