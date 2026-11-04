return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    -- catppuccin has no bufferline integration, so color it here in layers:
    -- a dark strip (crust), dim unfocused tabs on it, and a bright current tab
    -- (surface1) that stands apart from the editor below.
    local c = require('catppuccin.palettes').get_palette()
    local strip = c.crust
    local tab = c.surface1
    local on_strip = function(fg)
      return { fg = fg, bg = strip }
    end
    local on_tab = function(fg)
      return { fg = fg, bg = tab }
    end
    local selected = { fg = c.text, bg = tab, bold = true, italic = false }

    require('bufferline').setup {
      options = {
        indicator = { icon = '▎', style = 'icon' },
        separator_style = { '', '' },
        offsets = {
          {
            filetype = 'neo-tree',
            text = 'File Explorer',
            text_align = 'left',
            separator = true,
          },
        },
        show_buffer_close_icons = false,
        show_close_icon = false,
      },
      highlights = {
        fill = on_strip(c.overlay1),
        background = on_strip(c.overlay1),
        buffer_visible = on_strip(c.subtext0),
        numbers = on_strip(c.overlay1),
        numbers_visible = on_strip(c.subtext0),
        duplicate = on_strip(c.overlay0),
        duplicate_visible = on_strip(c.overlay0),
        modified = on_strip(c.peach),
        modified_visible = on_strip(c.peach),
        separator = on_strip(strip),
        separator_visible = on_strip(strip),
        indicator_visible = on_strip(strip),
        trunc_marker = on_strip(c.overlay1),
        offset_separator = on_strip(c.surface1),

        buffer_selected = selected,
        numbers_selected = selected,
        duplicate_selected = on_tab(c.subtext0),
        indicator_selected = on_tab(c.lavender),
        modified_selected = on_tab(c.peach),
        separator_selected = on_tab(tab),
        pick_selected = on_tab(c.red),
      },
    }
  end,
}
