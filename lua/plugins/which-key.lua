return {
  { -- Help see what keymaps are avaliable
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    config = function()
      local wk = require 'which-key'
      wk.add {
        { '<leader>f', group = 'File' },
        { '<leader>s', group = 'Search' },
        { '<leader>g', group = 'Git' },
        { 'ga', group = 'Lsp C[a]lls' },
        { '<leader>S', group = 'Scratch' },
        { '<leader>y', group = 'Yazi' },
      }
      wk.add {
        mode = { 'v', 'o' },
        { '.', desc = 'Smart textsubject selection' },
      }
    end,
    keys = {
      {
        '<leader>?',
        function()
          require('which-key').show { global = false }
        end,
        desc = 'Buffer Local Keymaps (which-key)',
      },
    },
  },
}
