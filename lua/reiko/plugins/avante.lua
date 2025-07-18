return  {
  'yetone/avante.nvim',
  event = 'VeryLazy',
  lazy = false,
  version = false,
  opts = {
    providers ={
      copilot = {
        endpoint = "https://api.githubcopilot.com",
        model = "gpt-4o-2024-11-20",
        proxy = nil, -- [protocol://]host[:port] Use this proxy
        allow_insecure = false, -- Allow insecure server connections
        timeout = 30000, -- Timeout in milliseconds
        context_window = 64000, -- Number of tokens to send to the model for context
        extra_request_body = {
          temperature = 0,
          max_tokens = 20480,
        },        
        ["bedrock_claude_3_7_sonnet"] = {
          hide_in_model_selector = true,
        },
        ["aihubmix_claude"] = {
          hide_in_model_selector = true,
        },
        aihubmix = {
          hide_in_model_selector = true,
        },
        openai = {
          hide_in_model_selector = true,
        },
        claude = {
          hide_in_model_selector = true,
        },
        gemini = {
          hide_in_model_selector = true,
        },
        vertex = {
          hide_in_model_selector = true,
        },
        vertex_claude = {
          hide_in_model_selector = true,
        },
        cohere = {
          hide_in_model_selector = true,
        },
        bedrock = {
          hide_in_model_selector = true,
        },
        ["claude-haiku"] = {
          hide_in_model_selector = true,
        },
        ["claude-opus"] = {
          hide_in_model_selector = true,
        },
        ["openai-gpt-4o-mini"] = {
          hide_in_model_selector = true,
        },
      },
    },
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
        clear = "<leader>az",
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
      parse_curl_args = function(opts, code_opts)
        return {
          url = opts.endpoint .. "/chat",
          headers = {
            ["Accept"] = "application/json",
            ["Content-Type"] = "application/json",
          },
          body = {
            model = opts.model,
            options = {
              num_ctx = 16384,
            },
            messages = require("avante.providers").copilot.parse_messages(code_opts), -- you can make your own message, but this is very advanced
            stream = true,
          },
        }
      end,
      parse_stream_data = function(data, handler_opts)
        -- Parse the JSON data
        local json_data = vim.fn.json_decode(data)
        -- Check for stream completion marker first
        if json_data and json_data.done then          
          handler_opts.on_stop({ reason = json_data.done_reason or "stop" })
          return
        end
        -- Process normal message content
        if json_data and json_data.message and json_data.message.content then
          -- Extract the content from the message
          local content = json_data.message.content
          -- Call the handler with the content
          handler_opts.on_chunk(content)
        end
      end, 
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false", -- for windows
    dependencies = {
      'stevearc/dressing.nvim',
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      'github/copilot.vim', -- for providers='copilot'
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
