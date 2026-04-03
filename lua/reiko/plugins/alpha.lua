return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  config = function()
    local alpha = require("alpha")
    local dashboard = require('alpha.themes.dashboard')
    
    dashboard.section.header.val = {
      [[⣿⣿⢟⣩⡬⠔⠼⣆⢸⣿⣿⣿⣿⢏⡾⠙⠻⠿⠿⢿⣿⣿⣿⡿⠻⣿⣿⣿⣿⣿]],
      [[⢏⣴⠟⣩⣾⣿⠷⣊⣘⠻⣯⣭⣥⣬⣤⣭⣬⣀⡂⠘⠿⠟⣋⣴⠇⣿⣿⣿⣿⣿]],
      [[⡾⣡⣾⡿⢟⡋⣾⣿⣿⣿⣎⠻⠿⠿⠿⠓⠒⠉⠛⠷⢮⣭⣝⡋⠘⡛⢿⣛⡛⣿]],
      [[⡃⢭⠍⣵⣿⡇⠹⣿⣿⣿⣿⢷⣬⠁⣎⠩⢭⡅⣷⣌⠲⣮⡛⢿⣷⣦⡙⢋⣴⣿]],
      [[⣿⠆⣾⣿⣿⡇⡷⣈⠫⢭⡑⢛⣛⣓⣈⣭⣭⣶⣾⣿⣶⡜⣿⣦⣻⣿⣿⣎⢻⣿]],
      [[⣿⢸⣿⢿⡿⢰⢰⢉⢱⣶⣦⡥⣈⣭⡍⣙⡻⣿⣿⣿⣿⣷⢸⣿⣧⠹⢿⣿⡆⣿]],
      [[⡇⢿⣿⡏⢣⠸⠤⢊⣼⣿⡟⣼⣯⣥⣾⣿⣿⣎⢻⣿⣿⣿⢸⣿⣿⡇⣆⢻⢃⣿]],
      [[⢇⢸⣿⣷⡘⣿⣿⣳⣿⣿⡇⣿⣿⣿⣿⣿⣿⣿⡎⣿⣿⡏⣜⢿⡟⣱⣏⣠⣌⠻]],
      [[⣼⡜⣿⣿⣷⡈⢾⣿⣿⣿⣷⡸⣿⣿⡿⢟⣭⣭⣾⣿⠟⣴⣿⣷⢰⣿⠘⢿⣿⣧]],
      [[⣿⡃⢻⣿⣿⣿⣦⣙⠿⠿⣿⣿⢮⣭⣶⣿⣿⣿⠟⠋⠈⠉⠉⣭⢨⡟⠘⡃⢹⡿]],
      [[⡿⢱⣎⢿⣿⣿⣿⣿⣯⣉⠁⣒⠛⠛⠛⠋⠉⠀⠀⠀⠀⡀⢠⣥⣴⢞⡄⣷⣶⣾]],
      [[⣁⣛⢛⣤⠻⣿⣿⡟⡛⠿⠿⢖⣢⣤⢖⣀⠀⢀⠒⡾⠋⣴⣿⣯⡐⢿⠃⣙⠻⠿]],
      [[⣿⡟⢸⡀⠀⠀⢉⣁⡙⠿⠟⣿⠋⣵⠌⣥⣾⡿⠔⣰⣾⣿⣿⣿⡟⡼⣸⣿⣿⣿]],
      [[⣿⣧⠸⠹⡃⢠⣿⣿⠟⣥⣥⣿⣷⣶⢆⡉⢥⠀⣿⣿⣿⣟⢋⡥⢞⣴⣿⣿⣿⣿]],
      [[⣿⣿⣦⣥⣬⠸⣿⣿⣜⣛⡋⢀⣿⣧⣙⡡⠗⣠⣿⡿⠿⠋⣨⣴⣿⣿⣿⣿⣿⣿]],
    }    

    dashboard.section.buttons.val = {
      dashboard.button("q", "❌  Quit NVIM", ":qa<CR>"),
      dashboard.button("n", "🔨  Create new project", ":NewProject<CR>"),

      dashboard.button("", ""),

      -- Changed D:/ to ~/ (Home directory) or your specific mount point
      dashboard.button("d", "💿  Open Home", ":silent Telescope file_browser path=~/<CR>"),
      dashboard.button("p", "📂  Open Projects", ":silent Telescope file_browser path=~/Projects<CR>"),
      dashboard.button("u", "📂  Open University", ":silent Telescope file_browser path=~/University<CR>"),

      dashboard.button("", ""),

      dashboard.button("D", "🔍  Search in Home", ":silent Telescope find_files cwd=~/<CR>"),
      dashboard.button("P", "🔍  Search in Projects", ":silent Telescope find_files cwd=~/Projects<CR>"),
      dashboard.button("U", "🔍  Search in University", ":silent Telescope find_files cwd=~/University<CR>"),

      dashboard.button("", ""),

      dashboard.button("o", "💾  Recently opened files", function()
        local builtin = require('telescope.builtin')
        if vim.g.oldfiles_first_time then
          builtin.oldfiles({
            attach_mappings = function(prompt_bufnr, map)
              local actions = require('telescope.actions')
              local function new_action(bufnr)
                local selection = require('telescope.actions.state').get_selected_entry()
                actions.close(bufnr)
                vim.cmd.edit(selection.path)
                vim.cmd.lcd(vim.fn.fnamemodify(selection.path, ':h'))
                vim.g.oldfiles_first_time = false
              end
              map('i', '<cr>', new_action)
              map('n', '<cr>', new_action)
              return true
            end,
          })
        else
          builtin.oldfiles()
        end
      end),

      -- Linux Config Paths
      dashboard.button("c", "⚙   Vim config", ":silent Telescope find_files cwd=~/.config/nvim<CR>"),
      dashboard.button("w", "⚙   Terminal config", ":silent Telescope find_files cwd=~/.config<CR>"),
      
      -- Linux delete commands (rm -rf) and data paths
      dashboard.button("r", "🗑️  Delete shada", ":!rm -rf ~/.local/state/nvim/shada/*<CR>"),
      dashboard.button("a", "🗑️  Delete swap", ":!rm -rf ~/.local/state/nvim/swap/*<CR>"),
      
      dashboard.button("t", "🖍️  Change theme", ":silent Telescope colorscheme<CR>"),
    }

    alpha.setup(dashboard.opts)

    vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
  end,
}
