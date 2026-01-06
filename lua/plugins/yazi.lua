return {
  'mikavilpas/yazi.nvim',
  event = 'VeryLazy',
  keys = {
    {
      '<leader>y',
      function()
        require('yazi').yazi()
      end,
      desc = 'Open yazi at the current file',
    },
    {
      '<leader>Y',
      function()
        require('yazi').yazi(nil, vim.fn.getcwd())
      end,
      desc = "Open yazi in nvim's working directory",
    },
    {
      '<leader>iw',
      function()
        require('yazi').toggle()
      end,
      desc = 'Resume the last yazi session',
    },
  },
  opts = {
    open_for_directories = true,
    keymaps = {
      show_help = '<f1>',
    },
  },
}
