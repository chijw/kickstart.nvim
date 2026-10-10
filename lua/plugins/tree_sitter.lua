return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  lazy = false,
  build = ':TSUpdate',
  opts = {
    ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc', 'python' },
  },
  config = function(_, opts)
    local treesitter = require 'nvim-treesitter'
    treesitter.setup {}

    local function attach(buf)
      if not vim.api.nvim_buf_is_valid(buf) then
        return
      end
      local ft = vim.bo[buf].filetype
      if ft == 'tex' or ft == 'latex' then
        return
      end
      if pcall(vim.treesitter.start, buf) then
        if ft == 'ruby' then
          vim.bo[buf].syntax = 'ruby'
        else
          vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end
    end

    treesitter.install(opts.ensure_installed):await(function()
      vim.schedule(function()
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          attach(buf)
        end
      end)
    end)
    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('config-treesitter', { clear = true }),
      callback = function(event)
        local ft = vim.bo[event.buf].filetype
        local lang = vim.treesitter.language.get_lang(ft)
        if ft == 'tex' or ft == 'latex' or not lang or not require('nvim-treesitter.parsers')[lang] then
          return
        end
        attach(event.buf)
        treesitter.install({ lang }):await(function()
          vim.schedule(function()
            attach(event.buf)
          end)
        end)
      end,
    })
  end,
}
