return {
  "github/copilot.vim",
  dependencies = { "catppuccin/nvim" },
  event = "VimEnter",
  init = function()
    vim.g.copilot_no_tab_map = false
    vim.g.copilot_workspace_folders = { vim.fn.getcwd() }
    vim.api.nvim_set_keymap("i", "<C-y>", "copilot#Accept('<CR>')", { silent = true, expr = true })
    vim.api.nvim_set_keymap("i", "<C-j>", "copilot#Next()", { silent = true, expr = true })
    vim.api.nvim_set_keymap("i", "<C-k>", "copilot#Prev()", { silent = true, expr = true })
    vim.api.nvim_set_keymap("i", "<C-d>", "copilot#Dismiss()", { silent = true, expr = true })
  end, 
}
