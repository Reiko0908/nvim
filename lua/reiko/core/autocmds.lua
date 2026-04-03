-- =========================================
-- 🧠 AUTOCMDS (Clean + Modern + Safe)
-- =========================================

-- Helper for augroups
local function augroup(name)
  return vim.api.nvim_create_augroup("reiko_" .. name, { clear = true })
end

-- =========================================
-- 💬 Comment string per filetype
-- =========================================
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("comment_string"),
  callback = function()
    local ft = vim.bo.filetype

    local comment_map = {
      c = "// %s",
      h = "// %s",
      cpp = "// %s",
      arduino = "// %s",
      python = "# %s",
      lua = "-- %s",
    }

    if comment_map[ft] then
      vim.bo.commentstring = comment_map[ft]
    end
  end,
})

-- =========================================
-- 🌲 Treesitter folding (modern + safe)
-- =========================================
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("folding"),
  callback = function()
    local ok = pcall(vim.treesitter.get_parser, 0)

    if ok then
      vim.opt_local.foldmethod = "expr"
      vim.opt_local.foldexpr = "nvim_treesitter#foldexpr()"
      vim.opt_local.foldlevel = 99
      vim.opt_local.foldenable = true
    else
      vim.opt_local.foldmethod = "syntax"
    end
  end,
})

-- =========================================
-- ✂️ Move cursor to end after yank
-- =========================================
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("yank_cursor"),
  callback = function()
    local event = vim.v.event

    if event.operator == "y" and (event.regname == "" or event.regname == '"') then
      local end_pos = vim.fn.getpos("']")
      vim.api.nvim_win_set_cursor(0, { end_pos[2], end_pos[3] - 1 })
    end
  end,
})

-- =========================================
-- ✨ (Optional) Highlight on yank
-- =========================================
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 150,
    })
  end,
})
