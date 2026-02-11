#!/usr/bin/env sh

# Current Theme
theme='powermenu'

# CMDs
uptime="$(uptime -p | sed -e 's/up //g')"
host=$(hostnamectl hostname)

# Options
shutdown='󰐥 Shutdown'
reboot=' Reboot'
lock='󰌾 Lock'
suspend='󰒲 Suspend'
logout='󰍃 Logout'
yes='✔ Yes'
no='✘ No'

# Rofi CMD
rofi_cmd() {
    rofi -dmenu \
        -p " $USER@$host" \
        -mesg "󱑁 Uptime: $uptime" \
        -theme ${theme}.rasi
}

# Confirmation CMD
confirm_cmd() {
    rofi -theme-str 'window {location: center; anchor: center; fullscreen: false; width: 350px;}' \
        -theme-str 'mainbox {orientation: vertical; children: [ "message", "listview" ];}' \
        -theme-str 'listview {columns: 2; lines: 1;}' \
        -theme-str 'element-text {horizontal-align: 0.5;}' \
        -theme-str 'textbox {horizontal-align: 0.5;}' \
        -dmenu \
        -p 'Confirmation' \
        -mesg 'Are you Sure?' \
        -theme ${theme}.rasi
}

# Ask for confirmation
confirm_exit() {
    printf "%s\n%s" "$yes" "$no" | confirm_cmd
}

# Pass variables to rofi dmenu
run_rofi() {
    printf "%s\n%s\n%s\n%s\n%s" "$lock" "$suspend" "$logout" "$reboot" "$shutdown" | rofi_cmd
}

# Execute Command
run_cmd() {
    selected="$(confirm_exit)"
    if [ "$selected" = "$yes" ]; then
        if [ "$1" = '--shutdown' ]; then
            systemctl poweroff
        elif [ "$1" = '--reboot' ]; then
            systemctl reboot
        elif [ "$1" = '--suspend' ]; then
            systemctl suspend
        elif [ "$1" = '--logout' ]; then
            loginctl terminate-user ""
        elif [ "$1" = '--lock' ]; then
            loginctl lock-session
        fi
    else
        exit 0
    fi
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
"$shutdown")
    run_cmd --shutdown
    ;;
"$reboot")
    run_cmd --reboot
    ;;
"$lock")
    run_cmd --lock
    ;;
"$suspend")
    run_cmd --suspend
    ;;
"$logout")
    run_cmd --logout
    ;;
esac
