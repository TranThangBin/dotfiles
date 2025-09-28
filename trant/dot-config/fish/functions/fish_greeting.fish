function fish_greeting
	if not status is-login
		if command -v fastfetch &>/dev/null
			fastfetch
		end
	end
end
