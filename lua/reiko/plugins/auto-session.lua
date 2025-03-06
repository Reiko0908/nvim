return {
  "rmagatti/auto-session",
  config = function()
    local auto_session = require("auto-session")
    auto_session.setup({
      auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
      auto_save = false, -- Enables/disables auto saving session on exit
      auto_restore = false, -- Enables/disables auto restoring session on start
      auto_create = false,      
      session_lens = {
        buftypes_to_ignore = {}, -- List of buffer types that should not be deleted from the session
        load_on_setup = true,
        theme_conf = { border = true },
        previewer = false,
        load_on_setup = true, -- Initialize on startup (requires Telescope)
        theme_conf = { -- Pass through for Telescope theme options
          -- layout_config = { -- As one example, can change width/height of picker
            --   width = 0.8,    -- percent of window
            --   height = 0.5,
            -- },
          },
          previewer = false, -- File preview for session picker

          mappings = {
            -- Mode can be a string or a table, e.g. {"i", "n"} for both insert and normal mode
            delete_session = { "i", "<C-D>" },
            alternate_session = { "i", "<C-S>" },
            copy_session = { "i", "<C-Y>" },
          },

          session_control = {
            control_dir = vim.fn.stdpath "data" .. "/auto_session/", -- Auto session control dir, for control files, like alternating between two sessions with session-lens
            control_filename = "session_control.json", -- File name of the session control file
          },
        },
      })

      vim.keymap.set("n", "<leader>ls", require("auto-session.session-lens").search_session, { noremap = true, desc = "[L]oad [S]ession" })
      vim.keymap.set("n", "<leader>ss", ":SessionSave<CR>", { noremap = true, desc = "[S]ave [S]ession" })
    end,
  }
