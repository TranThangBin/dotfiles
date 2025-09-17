if [ "$(tty)" = "/dev/tty1" ]; then
    echo "What type of session would you like to enter"
    echo "- [X]11"
    echo "- [W]ayland"
    echo "- [*] tty"
    printf "> "
    read -rk 1 session
    echo

    if [ "$session" = "X" ]; then
        exec startx
    elif [ "$session" = "W" ]; then
        exec uwsm start default
    fi
fi
