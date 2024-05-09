local wezterm = require("wezterm")
local mux = wezterm.mux
local config = {}

-- Use config builder object if possible
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- || settings
config.window_background_opacity = 0.9
config.font_size = 16
config.font = wezterm.font("CommitMono Nerd Font", { weight = "Regular", italic = false })
config.use_cap_height_to_scale_fallback_fonts = true

-- || color schemes
config.color_scheme = "Sublette"
--config.color_scheme = "Gogh (Gogh)"

-- || start in fullscreen
config.window_decorations = "RESIZE"
wezterm.on("gui-startup", function(cmd)
	local tab, pane, window = mux.spawn_window(cmd or {})
	window:gui_window():maximize()
end)

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
