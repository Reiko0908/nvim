return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
    { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
    { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
    { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },
    { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
    { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
    { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
    { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
    { "[B", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer prev" },
    { "]B", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer next" },
  },
  opts = {
    options = {
      mode = "tabs",
      close_command = function(n) require('bufdelete').bufdelete(n, true) end,  -- Ensure `bufdelete` is installed
      right_mouse_command = function(n) require('bufdelete').bufdelete(n, true) end,
      diagnostics = "coc",
      always_show_bufferline = false,
      diagnostics_indicator = function(_, _, diag)
        local icons = {
          Error = "",  -- Custom icon for error
          Warn = "",   -- Custom icon for warning
          Info = "",   -- Custom icon for info
          Hint = "",   -- Custom icon for hint
        }
        local ret = (diag.error and icons.Error .. diag.error .. " " or "")
        .. (diag.warning and icons.Warn .. diag.warning or "")
        return vim.trim(ret)
      end,

      offsets = {
        {
          filetype = "NvimTree",
          text = "File Explorer",
          text_align = "center",
          separator = true
        }
      },
      get_element_icon = function(opts)
        -- Custom filetype icons
        local filetype_icons = {
          lua = "",  -- Lua icon
          python = "",  -- Python icon
          -- Add more filetype icons here if needed
        }
        return filetype_icons[opts.filetype] or ""  -- Default icon for unknown filetypes
      end,
    },
  },
  config = function(_, opts)
    require("bufferline").setup(opts)
    -- Fix bufferline when restoring a session
    vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
      callback = function()
        vim.schedule(function()
          pcall(require("bufferline").update)
        end)
      end,
    })
  end,
}
