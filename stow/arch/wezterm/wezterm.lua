local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.color_scheme = "Gruvbox dark, hard (base16)"

config.font = wezterm.font("CaskaydiaCove Nerd Font Mono")

config.font_size = 13

config.enable_tab_bar = false

return config
