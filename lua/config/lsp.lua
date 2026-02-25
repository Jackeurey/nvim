local keymap = vim.keymap

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf, silent = true }

    -- set keybinds

    -- NOTE: Commenting out to see how I feel about the snack picker way of using this.
    -- opts.desc = 'Go to declaration'
    -- keymap.set('n', 'gD', vim.lsp.buf.declaration, opts) -- go to declaration
    -- opts.desc = 'Show LSP definition'
    -- keymap.set('n', 'gd', vim.lsp.buf.definition, opts) -- show lsp definition

    opts.desc = 'See available code actions'
    keymap.set({ 'n', 'v' }, 'ga', vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

    opts.desc = 'Smart rename'
    keymap.set('n', 'gR', vim.lsp.buf.rename, opts) -- smart rename

    opts.desc = 'Show line diagnostics'
    keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts) -- show diagnostics for line

    opts.desc = 'Go to previous diagnostic'
    keymap.set('n', '[d', function()
      vim.diagnostic.jump { count = -1, float = true }
    end, opts) -- jump to previous diagnostic in buffer
    --
    opts.desc = 'Go to next diagnostic'
    keymap.set('n', ']d', function()
      vim.diagnostic.jump { count = 1, float = true }
    end, opts) -- jump to next diagnostic in buffer
  end,
})

-- vim.lsp.inlay_hint.enable(true)

local severity = vim.diagnostic.severity

vim.diagnostic.config {
  signs = {
    text = {
      [severity.ERROR] = ' ',
      [severity.WARN] = ' ',
      [severity.HINT] = '󰠠 ',
      [severity.INFO] = ' ',
    },
  },
}
