return {
  "CopilotC-Nvim/CopilotChat.nvim",
  branch = "main",
  cmd = "CopilotChat",
  model = 'claude-3.5-sonnet',
  agent = 'copilot',
  dependencies = {
      { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
  },
  opts = function()
    local user = vim.env.USER or "Reiko"
    user = user:sub(1, 1):upper() .. user:sub(2)
    return {
      auto_insert_mode = true,
      question_header = "  " .. user .. " ",
      answer_header = "  Copilot ",
      error_header = "  Error ",
      insert_at_end = true,
      context = "buffers",
      highlight_selection = false,
      window = {
        width = 0.3,
        title = "Copilot Chat",
      },
    }
  end,
  mappings = {
    complete = {
      insert = '<Tab>',
    },
    close = {
      normal = 'q',
      insert = '<C-c>',
    },
    reset = {
      normal = '<C-r>',
      insert = '<C-r>',
    },
    submit_prompt = {
      normal = '<CR>',
      insert = '<C-s>',
    },
    toggle_sticky = {
      normal = 'grr',
    },
    clear_stickies = {
      normal = 'grx',
    },
    accept_diff = {
      normal = '<C-y>',
      insert = '<C-y>',
    },
    jump_to_diff = {
      normal = 'gj',
    },
    quickfix_answers = {
      normal = 'gqa',
    },
    quickfix_diffs = {
      normal = 'gqd',
    },
    yank_diff = {
      normal = 'gy',
      register = '"', -- Default register to use for yanking
    },
    show_diff = {
      normal = 'gd',
      full_diff = false, -- Show full diff instead of unified diff when showing diff window
    },
    show_info = {
      normal = 'gi',
    },
    show_context = {
      normal = 'gc',
    },
    show_help = {
      normal = 'gh',
    },
  },  
  keys = {
    { "<c-s>", "<CR>", ft = "copilot-chat", desc = "Submit Prompt", remap = true },
    { "<leader>z", "", desc = "+ai", mode = { "n", "v" } },
    {
      "<leader>za",
      ":CopilotChatToggle<CR>",
      desc = "Toggle (CopilotChat)",
      mode = { "n", "v" },
    },
    {
      "<leader>zx",
      ":CopilotChatClear<CR>",
      desc = "Clear (CopilotChat)",
      mode = { "n", "v" },
    },
    {
      "<leader>zq",
      function()
        vim.ui.input({
          prompt = "Quick Chat: ",
        }, function(input)
          if input ~= "" then
            require("CopilotChat").ask(input)
          end
        end)
      end,
      desc = "Quick Chat (CopilotChat)",
      mode = { "n", "v" },
    },
    { "<leader>zi",
    function()
      local actions = require("CopilotChat.actions")
      require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
    end, 
    desc = "CopilotChat - Telescope",
    mode = { "n", "v" },
  },
  {
    "<leader>zp",
    ":CopilotChatPrompts<CR>",
    desc = "Prompt Actions (CopilotChat)",
    mode = { "n", "v" },
  },
  {
    "<leader>zc",
    ":CopilotChatOpen<CR>",   
    desc = "Chat with Copilot",
    mode = { "n", "v" },
  },
  {
    "<leader>ze",
    ":CopilotChatExplain<CR>",
    desc = "Explain Code",
    mode = { "v" },
  },
  {
    "<leader>zr",
    ":CopilotChatReview<CR>",
    desc = "Review Code",
    mode = { "v" },
  },
  {
    "<leader>zf",
    ":CopilotChatFix<CR>",
    desc = "Fix Code Issues",
    mode = { "v" },
  },
  {
    "<leader>zo",
    ":CopilotChatOptimize<CR>",
    desc = "Optimize Code",
    mode = { "v" },
  },
  {
    "<leader>zd",
    ":CopilotChatDocs<CR>",
    desc = "Generate Docs",
    mode = { "v" },
  },
  {
    "<leader>zt",
    ":CopilotChatTests<CR>",
    desc = "Generate Tests",
    mode = { "v" },
  },
  {
    "<leader>zm",
    ":CopilotChatCommit<CR>",
    desc = "Generate Commit Message",
    mode = { "v" },
  },
  {
    "<leader>zs",
    ":CopilotChatCommit<CR>",
    desc = "Generate Commit for Selection",
    mode = { "v" },
  },
  {
    "<leader>zn",
    ":CopilotChatRename<CR>",
    desc = "Rename the variable",
    mode = { "v" },
  },
  {
    "<leader>zl",
    ":CopilotChatList<CR>",
    desc = "List all the available commands",
    mode = { "n", "v" },
  },
  {
    "<leader>zh",
    ":CopilotChatHelp<CR>",
    desc = "Show help",
    mode = { "n", "v" },
  },
  {
    "<leader>zw",
    ":CopilotChatWiki<CR>",
    desc = "Open Wiki",
    mode = { "n", "v" },
  },
  {
    "<leader>zd",
    ":CopilotChatDebug<CR>",
    desc = "Debug",
    mode = { "n", "v" },
  },
  {
    "<leader>z?",
    ":CopilotChatModels<CR>",
    desc = "Choose Models",
    mode = { "n" },
  },
},
config = function(_, opts)
  local chat = require("CopilotChat")
  vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "copilot-chat",
    callback = function()
      vim.opt_local.relativenumber = false
      vim.opt_local.number = false
    end,
  })

  chat.setup(opts)
end,
}

