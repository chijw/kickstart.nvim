-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
local args = vim.fn.argv()
if #args > 0 then
  local first_arg = args[1]
  if vim.fn.isdirectory(first_arg) == 1 then
    local target_dir = vim.fn.fnamemodify(first_arg, ':p')
    vim.api.nvim_set_current_dir(target_dir)
  end
end

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

if vim.env.SSH_TTY or vim.env.SSH_CONNECTION then
  vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
      local osc52 = require 'vim.ui.clipboard.osc52'
      local copy_plus = osc52.copy '+'
      copy_plus(vim.v.event.regcontents)
      local copy_star = osc52.copy '*'
      copy_star(vim.v.event.regcontents)
    end,
  })
end
