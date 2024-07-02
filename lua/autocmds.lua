--[[
NOTE: For More Documentation
  See :help lua-guide-autocommands
  and :help autocmd-events
-- ]]

local autocmds = {}

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank { timeout = 300 }
  end,
})

return autocmds
