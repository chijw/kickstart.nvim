vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- navigation
vim.keymap.set({ 'n', 'v', 'o' }, 'J', '5j', { noremap = true })
vim.keymap.set({ 'n', 'v', 'o' }, 'K', '5k', { noremap = true })
vim.keymap.set({ 'n', 'v', 'o' }, 'H', '5h', { noremap = true })
vim.keymap.set({ 'n', 'v', 'o' }, 'L', '5l', { noremap = true })

-- delete without yanking
vim.keymap.set('n', 'c', '"_c')
vim.keymap.set('n', 'cc', '"_cc')
vim.keymap.set('v', 'c', '"_c')

-- close/switch buffers
vim.keymap.set('n', 'x', ':bdelete<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 't', ':bnext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'T', ':bprevious<CR>', { noremap = true, silent = true })

vim.keymap.set('n', '<leader>x', ':q<CR>', { noremap = true, silent = true, desc = 'Close current window' })

vim.keymap.set('n', 'ee', function()
  vim.cmd 'term'
  vim.cmd 'startinsert'
end, { desc = 'Terminal' })

vim.keymap.set('n', 's', ':w<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'gs', 'gcc', { remap = true, desc = 'Toggle comment line' })
vim.keymap.set('v', 'gs', 'gc', { remap = true, desc = 'Toggle comment selection' })

-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- split screen configurations
vim.keymap.set('n', 'eh', ':set nosplitright<CR>:vsplit<CR>')
vim.keymap.set('n', 'el', ':set splitright<CR>:vsplit<CR>')
vim.keymap.set('n', 'ej', ':set nosplitbelow<CR>:split<CR>')
vim.keymap.set('n', 'ek', ':set splitbelow<CR>:split<CR>')

vim.keymap.set('n', '<up>', ':res +5<CR>')
vim.keymap.set('n', '<down>', ':res -5<CR>')
vim.keymap.set('n', '<left>', ':vertical res +5<CR>')
vim.keymap.set('n', '<right>', ':vertical res -5<CR>')
