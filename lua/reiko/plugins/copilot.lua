return {
  "github/copilot.vim",
  dependencies = { "catppuccin/nvim" },
  event = "VimEnter",
  init = function()
    vim.g.copilot_no_tab_map = false
    vim.g.copilot_workspace_folders = { vim.fn.getcwd() }

    -- Ensure the model is set correctly
    vim.fn.setenv("GITHUB_COPILOT_EDITOR_MODEL", "claude-3.7-sonet")
  end,
  keys = {},
}
