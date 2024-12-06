local wezterm = require("wezterm")

local habamax = {
	foreground = "#d0d0d0",
	background = "#1c1c1c",
	cursor_bg = "#d0d0d0",
	cursor_fg = "#1c1c1c",
	cursor_border = "#d0d0d0",
	selection_fg = "#1c1c1c",
	selection_bg = "#d0d0d0",
	ansi = {
		"#1c1c1c", -- black
		"#d75f5f", -- red
		"#87af87", -- green
		"#afaf87", -- yellow
		"#5f87af", -- blue
		"#af87af", -- magenta
		"#5f8787", -- cyan
		"#d0d0d0", -- white
	},
	brights = {
		"#666666", -- bright black
		"#ff8787", -- bright red
		"#87d7af", -- bright green
		"#d7d787", -- bright yellow
		"#87afd7", -- bright blue
		"#d7afd7", -- bright magenta
		"#87d7d7", -- bright cyan
		"#ffffff", -- bright white
	},
}

return {
	font_size = 15,
	macos_window_background_blur = 50,
	window_background_opacity = 0.9,
	enable_tab_bar = false,
	font = wezterm.font("0xProto", { weight = "Regular", italic = false }),
	colors = habamax,
}
