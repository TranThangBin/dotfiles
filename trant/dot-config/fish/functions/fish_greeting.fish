if not status is-login && not set -q ZELLIJ
    function fish_greeting
        if command -v fastfetch &>/dev/null
            fastfetch
        end
    end
end
