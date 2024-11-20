local wezterm = require("wezterm")

config = wezterm.config_builder()

config = {
    -- 自动加载配置
    automatically_reload_config = true,
    -- 标签栏
    enable_tab_bar = true,
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
    -- 切换面板缩放状态
    { key = 'Enter', mods = 'ALT', action = act.TogglePaneZoomState },
    -- 显示选项卡导航
    { key = 'e', mods = 'CTRL|SHIFT', action = act.ShowTabNavigator },
    -- 关闭当前窗格
    { key = 'w', mods = 'CTRL|SHIFT', action = act.CloseCurrentPane({ confirm = false }) },
    -- 垂直分割
    { key = 'd', mods = 'ALT|SHIFT', action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
    -- 水平分割
    { key = 'h', mods = 'ALT|SHIFT', action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
    -- 显示启动菜单
    { key = 'l', mods = 'ALT', action = act.ShowLauncher },
}

config.launch_menu = {}

for line in io.lines(wezterm.config_dir .. "/config") do
    for host in string.gmatch(line, "Host%s+([^%s]+)%s*") do
        table.insert(config.launch_menu, {
            label = host,
            args = { 'tssh', '-F', wezterm.config_dir .. "/config", host },
        })
    end
end

wezterm.log_info(config.launch_menu)

return config
