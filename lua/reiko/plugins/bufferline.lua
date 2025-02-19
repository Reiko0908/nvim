return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  version = "*",
  opts = {
    options = {
      mode = "tabs",
      diagnostics = "coc",
      -- separator_style = "slope",
      -- separator = true,
      -- separator_style = "thin",
      -- indicator = {
      --   icon = '▎',
      --   style = 'icon',
      -- },
      --
      offsets = {
        {
          filetype = "NvimTree",
          text = "File Explorer",
          text_align = "center",
          separator = true
        }
      },
    },
  },
}
