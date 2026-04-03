return {
  "tpope/vim-dadbod",
  opt = true,
  dependencies = {
    "kristijanhusak/vim-dadbod-ui",
    "kristijanhusak/vim-dadbod-completion",
  },
  config = function()
    require("reiko.core.dadbod")
  end,
}
