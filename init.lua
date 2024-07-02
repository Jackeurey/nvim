-- === General Documentation === --
--  See https://neovim.io/doc/user/lua-guide.html
--  or  :help lua-guide to read in vim
--
--  See <space>sh to [s]earch the [h]elp documentation
--  and :Tutor for a vim tutorial

-- === Section: Global Options === --
--  See :help mapleadert
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = true

require 'settings'
require 'keymaps'
require 'autocmds'
require 'plugins'

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
