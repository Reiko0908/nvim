return  {
  'yetone/avante.nvim',
  event = 'VeryLazy',
  lazy = false,
  version = false,
  opts = {
    provider = "copilot",
    copilot = {
      model = "claude-3.5-sonnet",
      behaviour = {
        auto_focus_sidebar = true,
        auto_suggestions = false, -- Experimental stage
        auto_suggestions_respect_ignore = false,
        auto_set_highlight_group = true,
        auto_set_keymaps = true,
        auto_apply_diff_after_generation = false,
        jump_result_buffer_on_finish = false,
        support_paste_from_clipboard = false,
        minimize_diff = true,
        enable_token_counting = true,
      },
      history = {
        max_tokens = 4096,
        storage_path = vim.fn.stdpath("state") .. "/avante",
        paste = {
          extension = "png",
          filename = "pasted-%Y-%m-%d-%H-%M-%S",
        },
      },
      highlights = {
        ---@type AvanteConflictHighlights
        diff = {
          current = "DiffText",
          incoming = "DiffAdd",
        },
      },
      mappings = {
        ---@class AvanteConflictMappings
        diff = {
          ours = "co",
          theirs = "ct",
          all_theirs = "ca",
          both = "cb",
          cursor = "cc",
          next = "]x",
          prev = "[x",
        },
        suggestion = {
          accept = "<M-l>",
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
        jump = {
          next = "]]",
          prev = "[[",
        },
        submit = {
          normal = "<CR>",
          insert = "<C-s>",
        },
        -- NOTE: The following will be safely set by avante.nvim
        ask = "<leader>aa",
        edit = "<leader>ae",
        refresh = "<leader>ar",
        focus = "<leader>af",
        toggle = {
          default = "<leader>at",
          debug = "<leader>ad",
          hint = "<leader>ah",
          suggestion = "<leader>as",
          repomap = "<leader>aR",
        },
        sidebar = {
          apply_all = "A",
          apply_cursor = "a",
          switch_windows = "<Tab>",
          reverse_switch_windows = "<S-Tab>",
          remove_file = "d",
          add_file = "@",
          close = { "<Esc>", "q" },
        },
        files = {
          add_current = "<leader>ac", -- Add current buffer to selected files
        },
      },
      windows = {
        ---@alias AvantePosition "right" | "left" | "top" | "bottom" | "smart"
        position = "right",
        wrap = true, -- similar to vim.o.wrap
        width = 30, -- default % based on available width in vertical layout
        height = 30, -- default % based on available height in horizontal layout
        sidebar_header = {
          enabled = true, -- true, false to enable/disable the header
          align = "center", -- left, center, right for title
          rounded = true,
        },
        input = {
          prefix = "> ",
          height = 8, -- Height of the input window in vertical layout
        },
        edit = {
          border = "rounded",
          start_insert = true, -- Start insert mode when opening the edit window
        },
        ask = {
          floating = false, -- Open the 'AvanteAsk' prompt in a floating window
          border = "rounded",
          start_insert = true, -- Start insert mode when opening the ask window
          ---@alias AvanteInitialDiff "ours" | "theirs"
          focus_on_apply = "ours", -- which diff to focus after applying
        },
      },
      --- @class AvanteConflictConfig
      diff = {
        autojump = true,
        --- Override the 'timeoutlen' setting while hovering over a diff (see :help timeoutlen).
        --- Helps to avoid entering operator-pending mode with diff mappings starting with `c`.
        --- Disable by setting to -1.
        override_timeoutlen = 500,
      },
      --- @class AvanteHintsConfig
      hints = {
        enabled = true,
      },
      --- @class AvanteRepoMapConfig
      repo_map = {
        ignore_patterns = { "%.git", "%.worktree", "__pycache__", "node_modules" }, -- ignore files matching these
        negate_patterns = {}, -- negate ignore files matching these.
      },
      file_selector = {
        provider = "telescope",
        provider_opts = {},
      },       
    },
  },
-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
build = 'powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false', -- for windows
dependencies = {
  'stevearc/dressing.nvim',
  'nvim-lua/plenary.nvim',
  'MunifTanjim/nui.nvim',
  'zbirenbaum/copilot.vim', -- for providers='copilot'
  --- The below dependencies are optional,
  'echasnovski/mini.icons',
  'MeanderingProgrammer/render-markdown.nvim',
  {
    -- support for image pasting
    'HakonHarnes/img-clip.nvim',
    event = 'VeryLazy',
    opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
  }
}
