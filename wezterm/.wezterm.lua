local wezterm = require 'wezterm'

local config = wezterm.config_builder()

-- config.color_scheme = 'Novel'
config.color_scheme = 'Purple Rain'

config.enable_scroll_bar = true

config.enable_tab_bar = false

config.font = wezterm.font {
    family = 'CodeNewRoman Nerd Font',
    weight = 500
}

config.colors = {
    scrollbar_thumb = "#7e56c2",
    cursor_fg = "white",
    cursor_bg = "purple"
}

config.keys = {
    { key = "1", mods = "ALT", action = wezterm.action.ActivateTab(0) }, 
    { key = "2", mods = "ALT", action = wezterm.action.ActivateTab(1) }, 
    { key = "3", mods = "ALT", action = wezterm.action.ActivateTab(2) }, 
    { key = "4", mods = "ALT", action = wezterm.action.ActivateTab(3) }, 
    { key = "5", mods = "ALT", action = wezterm.action.ActivateTab(4) }, 
    { key = "6", mods = "ALT", action = wezterm.action.ActivateTab(5) }, 
    { key = "7", mods = "ALT", action = wezterm.action.ActivateTab(6) }, 
    { key = "8", mods = "ALT", action = wezterm.action.ActivateTab(7) }, 
    { key = "9", mods = "ALT", action = wezterm.action.ActivateTab(8) }, 
    { 
        key = "|",
        mods = "CTRL|SHIFT",
        action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" } 
    },
    { 
        key = "_",
        mods = "CTRL|SHIFT",
        action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" } 
    }

}

return config




