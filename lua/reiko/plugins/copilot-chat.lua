return {
  "CopilotC-Nvim/CopilotChat.nvim",
  branch = "main",
  cmd = "CopilotChat",
  opts = function()
    local user = vim.env.USER or "User"
    user = user:sub(1, 1):upper() .. user:sub(2)
    return {
      auto_insert_mode = true,
      question_header = "  " .. user .. " ",
      answer_header = "  Copilot ",
      window = {
        width = 0.4,
      },
    }
  end,
  keys = {
    { "<c-s>", "<CR>", ft = "copilot-chat", desc = "Submit Prompt", remap = true },
    { "<leader>a", "", desc = "+ai", mode = { "n", "v" } },
    {
      "<leader>aa",
      ":CopilotChatToggle<CR>",
      desc = "Toggle (CopilotChat)",
      mode = { "n", "v" },
    },
    {
      "<leader>ax",
      ":CopilotChatClear<CR>",
      desc = "Clear (CopilotChat)",
      mode = { "n", "v" },
    },
    {
      "<leader>aq",
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
    {
      "<leader>ap",
      ":CopilotChatPrompts<CR>",
      desc = "Prompt Actions (CopilotChat)",
      mode = { "n", "v" },
    },
    {
      "<leader>ac",
      ":CopilotChat<CR>",
      desc = "Chat with Copilot",
      mode = { "n", "v" },
    },
    {
      "<leader>ae",
      ":CopilotChatExplain<CR>",
      desc = "Explain Code",
      mode = { "v" },
    },
    {
      "<leader>ar",
      ":CopilotChatReview<CR>",
      desc = "Review Code",
      mode = { "v" },
    },
    {
      "<leader>af",
      ":CopilotChatFix<CR>",
      desc = "Fix Code Issues",
      mode = { "v" },
    },
    {
      "<leader>ao",
      ":CopilotChatOptimize<CR>",
      desc = "Optimize Code",
      mode = { "v" },
    },
    {
      "<leader>ad",
      ":CopilotChatDocs<CR>",
      desc = "Generate Docs",
      mode = { "v" },
    },
    {
      "<leader>at",
      ":CopilotChatTests<CR>",
      desc = "Generate Tests",
      mode = { "v" },
    },
    {
      "<leader>am",
      ":CopilotChatCommit<CR>",
      desc = "Generate Commit Message",
      mode = { "v" },
    },
    {
      "<leader>as",
      ":CopilotChatCommit<CR>",
      desc = "Generate Commit for Selection",
      mode = { "v" },
    },
    {
      "<leader>an",
      ":CopilotChatRename<CR>",
      desc = "Rename the variable",
      mode = { "v" },
    },
    {
      "<leader>al",
      ":CopilotChatList<CR>",
      desc = "List all the available commands",
      mode = { "n", "v" },
    },
    {
      "<leader>ah",
      ":CopilotChatHelp<CR>",
      desc = "Show help",
      mode = { "n", "v" },
    },
    {
      "<leader>aw",
      ":CopilotChatWiki<CR>",
      desc = "Open Wiki",
      mode = { "n", "v" },
    },
    {
      "<leader>ai",
      ":CopilotChatInfo<CR>",
      desc = "Show Info",
      mode = { "n", "v" },
    },
    {
      "<leader>av",
      ":CopilotChatVersion<CR>",
      desc = "Show Version",
      mode = { "n", "v" },
    },
    {
      "<leader>ad",
      ":CopilotChatDebug<CR>",
      desc = "Debug",
      mode = { "n", "v" },
    },
    {
      "<leader>a?",
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

