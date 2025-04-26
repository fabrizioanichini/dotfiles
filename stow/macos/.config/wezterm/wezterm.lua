local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.color_scheme = "Gruvbox Dark (Gogh)"

config.font = wezterm.font("Cascadia Code NF")

config.font_size = 16

config.enable_tab_bar = false

config.window_decorations = "RESIZE"

config.window_close_confirmation = "NeverPrompt"

return config
