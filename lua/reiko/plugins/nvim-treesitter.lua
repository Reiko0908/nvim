return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },

    opts = {
      ensure_installed = {
        "c",
        "lua",
        "vim",
        "markdown",
        "python",
        "yaml",
        "java",
      },
      highlight = { enable = true },
      indent = { enable = true },
    },

    config = function(_, opts)
      -- ✅ FIX: Use the new main module instead of .configs
      require("nvim-treesitter.configs").setup(opts)

      -- set compilers
      require("nvim-treesitter.install").compilers = { "clang", "gcc" }

      -- folding (safe)
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- Modern way to do TS folding
      vim.opt.foldlevel = 99
    end,
  },
}
