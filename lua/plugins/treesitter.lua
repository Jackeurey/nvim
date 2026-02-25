return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
      ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'vim', 'vimdoc', 'heex', 'css', 'tsx', 'elixir' },
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby', 'elixir' },
      },
      indent = { enable = true, disable = { 'ruby', 'elixir' } },
    },
    config = function(_, opts)
      require('nvim-treesitter.install').prefer_git = true
      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup(opts)
    end,
  },
  { -- Textobjects for explicit selection and movement
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('nvim-treesitter-textobjects').setup {
        move = {
          enable = true,
          set_jumps = true, -- Adds jumps to the jumplist (so you can use Ctrl-o to go back)
        },
      }
      local move = require 'nvim-treesitter-textobjects.move'
      local keymap = vim.keymap

      -- Next Method
      keymap.set({ 'n', 'x', 'o' }, ']m', function()
        move.goto_next_start('@function.outer', 'textobjects')
      end, { desc = 'Next Method' })
      -- Previous Method
      keymap.set({ 'n', 'x', 'o' }, '[m', function()
        move.goto_previous_start('@function.outer', 'textobjects')
      end, { desc = 'Previous Method' })
    end,
  },
  { -- 1. Textsubjects for "smart" context-aware selection
    'RRethy/nvim-treesitter-textsubjects',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('nvim-treesitter-textsubjects').configure {
        prev_selection = ',', -- (Optional) Keymap to go back to the previous selection
        keymaps = {
          ['.'] = 'textsubjects-smart', -- Smart selection (expands outward)
          [';'] = 'textsubjects-container-outer', -- Select outer container (class/function)
          ['i;'] = 'textsubjects-container-inner', -- Select inner container (body)
        },
      }
    end,
  },
}
