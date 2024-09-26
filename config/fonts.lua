local wezterm = require('wezterm')
local platform = require('utils.platform')

--local font = 'JetBrainsMono Nerd Font'
--local font_size = platform().is_mac and 12 or 9

return {
    font_dirs = { 'fonts' },
    font_locator = 'ConfigDirsOnly',

    --font = wezterm.font(font),
    --font_size = font_size,
    font = wezterm.font_with_fallback {
        --{ family = "Operator Mono SSm", weight = "DemiLight", stretch = "Normal", style = "Italic" },
        { family = "Sarasa Term SC Nerd", weight = "DemiBold", stretch = "Normal", style = "Italic" },
    },

    font_size = 14,

    --ref: https://wezfurlong.org/wezterm/config/lua/config/freetype_pcf_long_family_names.html#why-doesnt-wezterm-use-the-distro-freetype-or-match-its-configuration
    freetype_load_target = 'Normal', ---@type 'Normal'|'Light'|'Mono'|'HorizontalLcd'
    freetype_render_target = 'Normal', ---@type 'Normal'|'Light'|'Mono'|'HorizontalLcd'
}
