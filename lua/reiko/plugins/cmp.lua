return {
  -- 1. Use the LUA version of copilot for copilot-cmp to work
  { 
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false }, -- Disable suggestions so cmp can handle them
        panel = { enabled = false },
      })
    end,
  },

  -- 2. The actual source for nvim-cmp
  { 
    "zbirenbaum/copilot-cmp", 
    config = function() require("copilot_cmp").setup() end 
  },

  -- 3. Standard sources
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "saadparwaiz1/cmp_luasnip" },
  
  -- 4. Add lazydev if you want Neovim Lua API completion (optional)
  { "folke/lazydev.nvim", ft = "lua", opts = {} },

  {
    "L3MON4D3/LuaSnip",
    dependencies = { "saadparwaiz1/cmp_luasnip", "rafamadriz/friendly-snippets" },
  },

  {
    "hrsh7th/nvim-cmp",
    config = function()
      local cmp = require("cmp")
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = false }),
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "copilot" }, -- Ensure copilot-cmp is installed to recognize this
        }, {
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },
}
