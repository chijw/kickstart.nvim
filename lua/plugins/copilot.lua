return {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  event = 'InsertEnter',
  config = function()
    require('copilot').setup {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 75,
        keymap = {
          accept = false,
          -- accept_word = false,
          -- accept_line = false,
          -- next = '<C-]>',
          -- prev = '<C-[>',
          -- dismiss = '<C-:>',
        },
      },
      panel = {
        enabled = true,
        auto_refresh = false,
        keymap = {
          jump_prev = '[[',
          jump_next = ']]',
          accept = '<CR>',
          refresh = 'gr',
          open = '<C-p>',
        },
        layout = {
          position = 'bottom',
          ratio = 0.4,
        },
      },
      -- filetypes = {
      --   markdown = true,
      --   help = false,
      --   gitcommit = false,
      --   gitrebase = false,
      --   hgcommit = false,
      --   svn = false,
      --   cvs = false,
      --   ['.'] = false,
      -- },
      copilot_node_command = 'node',
    }
  end,
}
