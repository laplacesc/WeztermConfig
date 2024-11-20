local wezterm = require("wezterm")

config = wezterm.config_builder()

config = {
    -- 自动加载配置
    automatically_reload_config = true,
    -- 关闭标签栏
    enable_tab_bar = false,
    -- 关闭窗口时无需确认
    window_close_confirmation = "NeverPrompt",
    -- 移除顶部三个图标的栏，但仍可以调整大小
    window_decorations = "RESIZE",
    -- 光标设为闪烁条形
    default_cursor_style = "BlinkingBar",
    -- 主题设置
    color_scheme = "Nord (Gogh)",
    -- 字体设置
    font_dirs = { 'fonts' },
    font_locator = 'ConfigDirsOnly',
    font = wezterm.font_with_fallback {
        -- { family = "Operator Mono SSm", weight = "DemiLight", stretch = "Normal", style = "Italic" },
        { family = "Sarasa Term SC Nerd", weight = "DemiBold", stretch = "Normal", style = "Italic" },
    },
    font_size = 14,
    background = {
        {
            source = {
                Color = "#282c35",
            },
            width = "100%",
            height = "100%",
            opacity = 0.8,
        }
    },
    window_padding = {
        left = 3,
        right = 3,
        top = 0,
        bottom = 0,
    },
    initial_cols = 120,
    initial_rows = 40,
}

local act = wezterm.action

config.keys = {
    { key = 'Enter', mods = 'ALT', action = act.TogglePaneZoomState },
    { key = 'E', mods = 'CTRL|SHIFT', action = act.ShowTabNavigator },
    { key = 'w', mods = 'CTRL|SHIFT', action = act.CloseCurrentPane({ confirm = false }) },
    { key = 'd', mods = 'ALT|SHIFT', action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
    { key = 'h', mods = 'ALT|SHIFT', action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
    { key = 'l', mods = 'ALT', action = wezterm.action.ShowLauncher },
}

config.launch_menu = {
    {
        label = '97',
        args = { 'tssh', '97' },
    },
    {
        label = '41',
        args = { 'tssh', '41' },
    },
    {
        label = '101',
        args = { 'tssh', '41' },
    },
}

return config
