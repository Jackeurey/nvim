return {
  {
    "saghen/blink.cmp",
    dependencies = {
      "folke/lazydev.nvim",
    },
    version = '1.*',
    opts = {
      sources = {
        default = { "lazydev", "lsp", "path", "snippets", "buffer" },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100,
          },
        },
      },
      completion = {
        ghost_text = {enabled = true,},
      },
      signature = {
        enabled = true,
        window = {show_documentation = false},
      },
    },
  },
}
