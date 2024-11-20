local wezterm = require("wezterm")

config = wezterm.config_builder()

config = {
    -- 自动加载配置
    automatically_reload_config = true,
    -- 标签栏
    enable_tab_bar = true,
    hide_tab_bar_if_only_one_tab = true,
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
    -- 显示启动菜单
    { key = 'l', mods = 'ALT', action = act.ShowLauncher },
    -- 切换面板缩放状态
    { key = 'Enter', mods = 'ALT', action = act.TogglePaneZoomState },
    -- 显示选项卡导航
    { key = 'D', mods = 'CTRL|SHIFT', action = act.ShowTabNavigator },
    -- 关闭当前窗格
    { key = 'W', mods = 'CTRL|SHIFT', action = act.CloseCurrentPane({ confirm = false }) },
    -- 垂直分割
    { key = 'D', mods = 'ALT|SHIFT', action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
    -- 水平分割
    { key = 'H', mods = 'ALT|SHIFT', action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
    -- 修改当前选项卡标题
    {
        key = 'E',
        mods = 'CTRL|SHIFT',
        action = act.PromptInputLine {
            description = 'Enter new name for tab',
            action = wezterm.action_callback(function(window, pane, line)
                if line then
                    window:active_tab():set_title(line)
                end
            end),
        },
    },
}

local ssh_config = wezterm.config_dir .. "/config"

config.launch_menu = {
    {
        label = "tssh",
        args = { 'tssh', '-F', ssh_config },
    },
    {
        label = "tssh add new host",
        args = { 'tssh', '-F', ssh_config, "--new-host" },
    },
}

for line in io.lines(ssh_config) do
    for host in string.gmatch(line, "Host%s+([^%s]+)%s*") do
        table.insert(config.launch_menu, {
            label = host,
            args = { 'tssh', '-F', ssh_config, host },
        })
    end
end

wezterm.on('format-tab-title', function(tab)
    local pane = tab.active_pane
    local title = pane.title
    if pane.domain_name then
        title = title .. ' - (' .. pane.domain_name .. ')'
    end
    return title
end)

return config
