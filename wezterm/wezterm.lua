local wezterm = require("wezterm")
local config = {}

-- Use config builder object if possible
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- || settings
config.window_background_opacity = 0.9
config.font_size = 16
config.font = wezterm.font("CommitMono Nerd Font", { weight = "Regular", italic = false })
config.window_decorations = "RESIZE"
config.use_cap_height_to_scale_fallback_fonts = true

-- dim inactive panes
config.inactive_pane_hsb = {
	saturation = 0.24,
	brightness = 0.5,
}

-- window padding
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

return config
