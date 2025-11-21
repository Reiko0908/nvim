local conventional = require "reiko.core.project_setup.conventional"

vim.g.project_types = {
  "Python",
  "C",
  "C++",
  "Assembly"
}
-- ---- COMMANDS ----------------------------------------------------------------------------------------------
vim.api.nvim_create_user_command("SelectProjectType", function()
  local co = coroutine.running()
  vim.ui.select(
    vim.g.project_types,
    {
      prompt = "Select:",
      format_item = function(item) return item end
    },
    function(choice)
      if choice then
        vim.g.project_type = choice
        print("You selected:", choice)
      else
        print("No selection made")
      end
    end
  )
end, {})

-- ---- KEY MAPPINGS ----------------------------------------------------------------------------------------------
vim.keymap.set("n", "<leader>r", function()
  if vim.g.project_type == "none" then return
  elseif vim.g.project_type == "C++" then conventional.compile_cpp()
  elseif vim.g.project_type == "C" then conventional.compile_c()
  end
end, {desc = "compile or [R]un project"})

vim.keymap.set("n", "<leader>u", function()
  if vim.g.project_type == 'none' then return
  elseif vim.g.project_type == 'C++' then conventional.run_cpp()
  elseif vim.g.project_type == 'C' then conventional.run_c()
  elseif vim.g.project_type == 'Python' then conventional.run_python()
  elseif vim.g.project_type == 'Assembly' then conventional.run_asm()
  end
end, {desc = "[U]pload"})
