return {
  'lervag/vimtex',
  lazy = false,
  init = function()
    vim.g.vimtex_view_method = vim.fn.has 'macunix' == 1 and 'skim' or 'general'
    vim.g.vimtex_view_general_viewer = 'xdg-open'
    vim.g.vimtex_quickfix_mode = 0
    vim.g.vimtex_view_skim_sync = 1
    vim.g.vimtex_view_skim_activate = 1
    if vim.fn.has 'macunix' == 0 and not vim.env.DISPLAY and not vim.env.WAYLAND_DISPLAY then
      vim.g.vimtex_view_enabled = 0
    end
    vim.g.vimtex_quickfix_open_on_warning = 0

    vim.g.vimtex_compiler_latexmk = {
      aux_dir = 'build',
      out_dir = 'build',
      callback = 1,
      continuous = 1,
      executable = 'latexmk',
      options = {
        '-verbose',
        '-file-line-error',
        '-synctex=1',
        '-interaction=nonstopmode',
      },
    }
    vim.g.vimtex_compiler_latexmk_engines = {
      _ = '-xelatex',
    }
  end,
}

-- return {
--   'lervag/vimtex',
--   lazy = false,
--   init = function()
--     vim.g.vimtex_view_method = 'sioyek'
--     vim.g.vimtex_view_sioyek_exe = 'sioyek'
--
--     vim.g.vimtex_quickfix_mode = 0
--     vim.g.vimtex_quickfix_open_on_warning = 0
--   end,
-- }
