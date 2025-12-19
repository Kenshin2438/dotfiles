local wezterm = require("wezterm")
local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

--- Font ---
config.font = wezterm.font_with_fallback({ "FiraCode Nerd Font", "LXGW WenKai Mono" })
config.font_rules = {
	{ italic = true, font = wezterm.font("IBM Plex Mono", { italic = true }) },
}
config.font_size = 11
config.command_palette_font_size = 11

--- window ---
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.integrated_title_button_style = "Windows"
config.integrated_title_button_alignment = "Right"
config.integrated_title_buttons = { "Hide", "Maximize", "Close" }
config.initial_cols = 120
config.initial_rows = 40
config.enable_scroll_bar = false
config.show_new_tab_button_in_tab_bar = false

--- Theming ---
config.color_scheme = "Ayu Mirage"
-- config.window_background_opacity = 0.95
-- config.win32_system_backdrop = "Acrylic"
config.window_frame = { font = config.font }

--- Launcher ---
config.default_prog = { "nu" }
-- config.default_prog = {"pwsh", "-NoLogo"}

--- KeyBindings ---
config.disable_default_key_bindings = false
config.keys = {
	{ key = "F11", mods = "NONE", action = wezterm.action.ToggleFullScreen },
}

--- Misc ---
config.audible_bell = "Disabled"
config.max_fps = 120

return config
