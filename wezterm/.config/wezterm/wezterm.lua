local wezterm = require 'wezterm';
return {
  font = wezterm.font("FiraCode Nerd Font"),
  font_rules= {
    -- Select a fancy italic font for italic text
    {
      italic = true,
      font = wezterm.font("Hack Nerd Font", {italic=true}),
    },

    -- Similarly, a fancy bold+italic font
    -- {
    --   italic = true,
    --   intensity = "Bold",
    --   font = font_with_fallback("Operator Mono SSm Lig Book Italic"),
    -- },

    -- Make regular bold text a different color to make it stand out even more
    {
      intensity = "Bold",
      font = wezterm.font("FiraCode Nerd Font", {bold=true}),
    },

    -- For half-intensity text, use a lighter weight font
    -- {
    --   intensity = "Half",
    --   font = font_with_fallback("Operator Mono SSm Lig Light"),
    -- },
  },
  font_size = 14.0,
  color_scheme = "Dracula+",
}
