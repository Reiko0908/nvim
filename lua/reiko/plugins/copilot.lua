return {
  "github/copilot.vim",
  dependencies = { "catppuccin/nvim" },
  event = "VimEnter",
  init = function()
    vim.g.copilot_no_tab_map = false
    vim.g.copilot_workspace_folders = { vim.fn.getcwd() }
  end,
  keys = {
    { "<C-l>", "<Plug>(copilot-accept-line)", mode = "i", desc = "Accept Copilot suggestion line" }
  },
}
