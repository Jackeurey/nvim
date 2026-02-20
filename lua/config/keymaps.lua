--[[
  NOTE: For More Documentation   
  See :help vim.keymap.set()
--]]
local keymaps = {}

-- Clear highlighted search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Center screen after moving between in searches
vim.keymap.set('n', 'n', 'nzz')
vim.keymap.set('n', 'N', 'Nzz')

-- Center to top of screen after page up and down
vim.keymap.set('n', '<C-d>', '<C-d>zt')
vim.keymap.set('n', '<C-u>', '<C-u>zt')

-- Stay in visual mode after indent
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

return keymaps
