local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.color_scheme = "tokyonight_night"
config.window_background_opacity = 0.95
config.font = wezterm.font("Hack Nerd Font")

config.default_prog = { "distrobox", "enter", "dev" }

return config
