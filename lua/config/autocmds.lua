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
