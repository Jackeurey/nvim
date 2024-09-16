return {
  { -- LSP configurations & plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      -- Useful status updates for LSP.
      { 'j-hui/fidget.nvim', opts = {} },
      -- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
      -- used for completion, annotations and signatures of Neovim apis
      { 'folke/lazydev.nvim', opts = {} },
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = desc })
          end
          local telescope = require 'telescope.builtin'
          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          map('gd', telescope.lsp_definitions, '[G]oto [D]efinition')
          --  Jump to the declaration. For example, in C this would take you to the header.
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
          -- Jump to the implementation of the word under your cursor.
          --  For example, in Java this would show you implementations of an interface
          --  instead of the definition of said interface.
          map('gI', telescope.lsp_implementations, '[G]oto [I]mplementation')
          -- Find references for the word under your cursor.
          map('gr', telescope.lsp_references, '[G]oto [R]eferences')
          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map('gy', telescope.lsp_type_definitions, '[G]oto T[y]pe')
          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map('<leader>ld', telescope.lsp_document_symbols, '[L]sp [D]ocument Symbols')
          -- Fuzzy find all the symbols in your current workspace.
          --  Similar to document symbols, except searches over your entire project.
          map('<leader>lw', telescope.lsp_dynamic_workspace_symbols, '[L]sp [W]orkspace Symbols')
          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map('<leader>lr', vim.lsp.buf.rename, '[L]sp [R]ename')
          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('<leader>la', vim.lsp.buf.code_action, '[L]sp Code [A]ction')
          -- Opens a popup that displays documentation about the word under your cursor
          --  See `:help K` for why this keymap.
          map('K', vim.lsp.buf.hover, 'Hover Documentation')
          -- Autocmd to highlight references when you rest your cursor
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = true })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })
            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- Autocmd to set keybind for toggling lsp inlay hints if lsp inlay hints are supported by the lsp
          if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled {})
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      -- Servers to include by default.
      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              -- diagnostics = { disable = { 'missing-fields' } },
              -- NOTE: Have not experienced this yet but will keep this here for awhile just incase...
            },
          },
        },
      }
      -- Add nvim-cmp and luasnip (auto completion) support to the Neovim lsp client
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
      require('mason').setup()
      -- Install default servers and other non server things that Mason supports like formatters
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format Lua code
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }
      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- Overwrites only values that were explicityly passed by the server configurations above
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },
  {
    'elixir-tools/elixir-tools.nvim',
    version = '*',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local elixir = require 'elixir'
      local elixirls = require 'elixir.elixirls'

      elixir.setup {
        nextls = { enable = true },
        credo = { enable = true },
        elixirls = {
          enable = true,
          settings = elixirls.settings {
            dialyzerEnabled = true,
            enableTestLenses = true,
          },
          on_attach = function(_, _)
            --   vim.keymap.set('n', '<leader>fp', ':ElixirFromPipe<cr>', { buffer = true, noremap = true })
            --   vim.keymap.set('n', '<leader>tp', ':ElixirToPipe<cr>', { buffer = true, noremap = true })
            --   vim.keymap.set('v', '<leader>em', ':ElixirExpandMacro<cr>', { buffer = true, noremap = true })
            --   vim.keymap.set('n', '<leader>rt', vim.lsp.codelens.run)
            -- TODO: figure out what keybindings I want and what they should be
          end,
        },
      }
    end,
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
  },
}
