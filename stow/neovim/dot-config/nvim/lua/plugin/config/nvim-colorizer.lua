require("colorizer").setup({
	filetypes = {
		"html",
		"css",
		"javascript",
		"typescript",
		"templ",
		cmp_menu = { always_update = true },
		cmp_docs = { always_update = true },
	},
	user_default_options = {
		names = false,
		rgb_fn = true,
		hsl_fn = true,
		css = true,
		css_fn = true,
		tailwind = "both",
		tailwind_opts = {
			update_names = true,
		},
	},
})
