return {
  { "hrsh7th/cmp-nvim-lsp" },
  { "saadparwaiz1/cmp_luasnip" },
  { "rafamadriz/friendly-snippets" },
  { "github/copilot.vim" },
  { "zbirenbaum/copilot-cmp", config = function() require("copilot_cmp").setup() end },
  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    dependencies = { "saadparwaiz1/cmp_luasnip", "rafamadriz/friendly-snippets" },
  },
  {
    "hrsh7th/nvim-cmp",
    config = function()
      local cmp = require("cmp")
      -- Load snippets from friendly-snippets
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = 'copilot'}
        }, {
            { name = "buffer" },
            { name = "path"},
          }),
      })
    end,
  },
}
