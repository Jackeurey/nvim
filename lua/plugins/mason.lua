return {
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      -- list of servers for mason to install
      ensure_installed = {
        "lua_ls",
        "pyright"
      },
    },
    dependencies = {
      { "williamboman/mason.nvim", config = true,},
      "neovim/nvim-lspconfig",
      { 'j-hui/fidget.nvim', opts = {} },
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        "stylua", -- lua formatter
        "debugpy", -- Python Debugger
        "autopep8", -- Python Formatter
      },
    },
    dependencies = {
      "williamboman/mason.nvim",
    },
  },
}
