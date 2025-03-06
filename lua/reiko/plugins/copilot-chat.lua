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
      function()
        return require("CopilotChat").toggle()
      end,
      desc = "Toggle (CopilotChat)",
      mode = { "n", "v" },
    },
    {
      "<leader>ax",
      function()
        return require("CopilotChat").reset()
      end,
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
      function()
        require("CopilotChat").select_prompt()
      end,
      desc = "Prompt Actions (CopilotChat)",
      mode = { "n", "v" },
    },
    {
        "<leader>ac",
        function()
            return require("CopilotChat").toggle()
        end,
        desc = "Chat with Copilot",
        mode = { "n", "v" },
    },
    {
        "<leader>ae",
        function()
            return require("CopilotChat").explain()
        end,
        desc = "Explain Code",
        mode = { "v" },
    },
    {
        "<leader>ar",
        function()
            return require("CopilotChat").review()
        end,
        desc = "Review Code",
        mode = { "v" },
    },
    {
        "<leader>af",
        function()
            return require("CopilotChat").fix()
        end,
        desc = "Fix Code Issues",
        mode = { "v" },
    },
    {
        "<leader>ao",
        function()
            return require("CopilotChat").optimize()
        end,
        desc = "Optimize Code",
        mode = { "v" },
    },
    {
        "<leader>ad",
        function()
            return require("CopilotChat").docs()
        end,
        desc = "Generate Docs",
        mode = { "v" },
    },
    {
        "<leader>at",
        function()
            return require("CopilotChat").tests()
        end,
        desc = "Generate Tests",
        mode = { "v" },
    },
    {
        "<leader>am",
        function()
            return require("CopilotChat").commit()
        end,
        desc = "Generate Commit Message",
        mode = { "v" },
    },
    {
        "<leader>as",
        function()
            return require("CopilotChat").commit_selection()
        end,
        desc = "Generate Commit for Selection",
        mode = { "v" },
    },
    {
        "<leader>an",
        function()
            return require("CopilotChat").rename()
        end,
        desc = "Rename the variable",
        mode = { "v" },
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

