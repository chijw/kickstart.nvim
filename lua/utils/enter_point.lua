local module = {}

module.shell_runner = require 'utils.shell_runner'
vim.keymap.set('n', '<leader>r', module.shell_runner.run_cmd_float, { desc = 'Run Command in Float' })
