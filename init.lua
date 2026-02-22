-- Set Leader Keys
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

-- Load Core
require 'config.settings'
require 'config.keymaps'
require 'config.autocmds'
require 'config.lsp'

-- Load Plugins
require 'config.lazy'
