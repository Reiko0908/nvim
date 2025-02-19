return {
  'rcarriga/nvim-notify',
  event = "VeryLazy",
  config = function()
    require("notify").setup({
      render = "compact",
      top_down = false,
      stages = "static",
    })
  end,
}
