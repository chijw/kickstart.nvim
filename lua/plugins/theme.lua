-- return {
--   -- You can easily change to a different colorscheme.
--   -- Change the name of the colorscheme plugin below, and then
--   -- change the command in the config to whatever the name of that colorscheme is.
--   --
--   -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
--   'folke/tokyonight.nvim',
--   priority = 1000, -- Make sure to load this before all the other start plugins.
--   config = function()
--     ---@diagnostic disable-next-line: missing-fields
--     require('tokyonight').setup {
--       styles = {
--         comments = { italic = false }, -- Disable italics in comments
--       },
--       on_highlights = function(hl, _)
--         hl.WinSeparator = {
--           fg = '#888888',
--           bold = true,
--         }
--       end,
--     }
--     -- Load the colorscheme here.
--     -- Like many other themes, this one has different styles, and you could load
--     -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
--     vim.cmd.colorscheme 'tokyonight-night'
--   end,
-- }
--
return {
  'catppuccin/nvim',
  name = 'catppuccin',
  lazy = false,
  priority = 1000,
  config = function()
    require('catppuccin').setup {
      flavour = 'mocha',
      -- Mocha accents on neutral, slightly lifted grays (no blue tint).
      -- kitty and tmux use the same values; keep them in sync if you change these.
      color_overrides = {
        mocha = {
          overlay2 = '#9d9da3',
          overlay1 = '#85858b',
          overlay0 = '#6c6c72',
          surface2 = '#4a4a4f',
          surface1 = '#3a3a3e',
          surface0 = '#2c2c2f',
          base = '#1f1f21',
          mantle = '#18181a',
          crust = '#121214',
        },
      },
      -- Let kitty's translucent, blurred background show through; popups stay solid.
      transparent_background = true,
      float = { transparent = false, solid = false },
      -- Inactive splits get a darker solid background, so the focused one stands out.
      dim_inactive = { enabled = true, shade = 'dark', percentage = 0.15 },
      styles = {
        comments = { 'italic' }, -- Cascadia's cursive italic
        conditionals = { 'italic' },
      },
      custom_highlights = function(colors)
        return {
          WinSeparator = { fg = colors.surface1 },
          VertSplit = { fg = colors.surface1 },
          ['@variable.parameter'] = { fg = colors.maroon, italic = true },
          ['@variable.builtin'] = { fg = colors.red, italic = true }, -- self, cls
        }
      end,
      -- custom_highlights = function(colors)
      --   local dark = '#1f1f23'
      --   local darker = '#2f2f33'
      --   return {
      --     Normal = { bg = dark },
      --     NormalNC = { bg = darker },
      --     NormalFloat = { bg = dark },
      --     CursorLine = { bg = colors.surface0 },
      --     Visual = { bg = colors.surface1 },
      --     WinSeparator = {
      --       fg = colors.crust,
      --       bold = true,
      --     },
      --   }
      -- end,
    }
    vim.cmd.colorscheme 'catppuccin-nvim'
  end,
}
