return {
  "rmagatti/auto-session",
  lazy = false,
  config = function()
    local auto_session = require("auto-session")
    auto_session.setup({
      auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
      auto_save = false,
      auto_restore = false,
      auto_create = false,
      session_lens = {
        buftypes_to_ignore = {},
        load_on_setup = true, -- Prevents double loading
        theme_conf = { border = true },
        previewer = false,
        mappings = {
          delete_session = { "i", "<C-D>" },
          alternate_session = { "i", "<C-S>" },
          copy_session = { "i", "<C-Y>" },
        },
        session_control = {
          control_dir = vim.fn.stdpath "data" .. "/auto_session/",
          control_filename = "session_control.json",
        },
      },
    })

    -- Fix multiple tabs issue
    vim.o.sessionoptions = "buffers,curdir,folds,help,winpos,winsize"

    -- Ensure only one tab is open before loading a session
    vim.keymap.set("n", "<leader>ls", function()
      vim.cmd("tabonly") -- Close extra tabs
      require("auto-session.session-lens").search_session()
    end, { noremap = true, desc = "[L]oad [S]ession" })

    vim.keymap.set("n", "<leader>ss", ":SessionSave<CR>", { noremap = true, desc = "[S]ave [S]ession" })
  end,
}

