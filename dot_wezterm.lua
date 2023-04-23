local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.color_scheme = "tokyonight_moon"
config.window_background_opacity = 1.0
config.font = wezterm.font("Hack Nerd Font")
config.font_size = 16

config.default_prog = { "toolbox", "run", "-c", "dev", "zsh" }
config.use_ime = false

return config
