local module = {}

local last_run_cmd = ''
module.run_cmd_float = function()
  local cmd = vim.fn.input('Command: ', last_run_cmd, 'shellcmd')
  if cmd == '' then
    return
  end
  last_run_cmd = cmd
  vim.fn.histadd('cmd', cmd)
  local output = vim.fn.systemlist(cmd)
  if #output == 0 then
    print 'Command finished with no output.'
    return
  end

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, output)

  local max_w = math.ceil(vim.o.columns * 0.6)
  local max_h = math.ceil(vim.o.lines * 0.5)
  local win_height = math.min(#output, max_h)
  local longest_line = 0
  for _, line in ipairs(output) do
    longest_line = math.max(longest_line, #line)
  end
  local win_width = math.min(longest_line + 2, max_w)
  if win_width < 30 then
    win_width = 30
  end

  local row = math.floor((vim.o.lines - win_height) / 2) - 1
  local col = math.floor((vim.o.columns - win_width) / 2)

  local _ = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = win_width,
    height = win_height,
    row = math.max(0, row),
    col = math.max(0, col),
    style = 'minimal',
    border = 'rounded',
    title = ' Result ',
    title_pos = 'center',
  })

  local opts = { noremap = true, silent = true, buffer = buf }
  vim.keymap.set('n', 'q', '<cmd>close<cr>', opts)
  vim.keymap.set('n', '<Esc>', '<cmd>close<cr>', opts)
end

return module
