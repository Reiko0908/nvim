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
      dashboard.button( "q", "❌  Quit NVIM" , ":qa<CR>"),
      dashboard.button("n", "🔨  Create new project", ":NewProject<CR>"),

      dashboard.button("",""), -- For some spacing

      dashboard.button("d", "💿  Open D drive", ":silent Telescope file_browser path=D:/<CR>"),
      dashboard.button("p", "📂  Open Project folder", ":silent Telescope file_browser path=D:/Project<CR>"),
      dashboard.button("u", "📂  Open University folder", ":silent Telescope file_browser path=D:/University<CR>"),

      dashboard.button("",""), -- For some spacing

      dashboard.button("D", "🔍  Search in D drive", ":silent Telescope find_files cwd=D:/<CR>"),
      dashboard.button("P", "🔍  Search in Project folder", ":silent Telescope find_files cwd=D:/Project<CR>"),
      dashboard.button("U", "🔍  Search in University folder", ":silent Telescope find_files cwd=D:/University<CR>"),

      dashboard.button("",""), -- For some spacing

      -- dashboard.button("SPC f o", "💾  Recently opened files"),
      -- dashboard.button("SPC v c", "⚙  Vim config"),
      -- dashboard.button("SPC c s", "🖍️  Change coloscheme"),

      dashboard.button("o", "💾  Recently opened files", function()
        local builtin = require('telescope.builtin')
        if vim.g.oldfiles_first_time then -- ensure CD into the file in first open
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
      dashboard.button("c", "⚙   Vim config", ":silent Telescope find_files cwd=C:/Users/Reiko/AppData/Local/nvim<CR>"),
      dashboard.button("w", "⚙   Wezterm config", ":silent Telescope find_files cwd=C:/Users/Reiko/.config<CR>"),
      dashboard.button("r", "🗑️  Delete shada", ":!del C:\\Users\\Reiko\\AppData\\Local\\nvim-data\\shada /Q<CR>"),
      dashboard.button("a", "🗑️  Delete swap", ":!del C:\\Users\\Reiko\\AppData\\Local\\nvim-data\\swap /Q<CR>"),
      dashboard.button("t", "🖍️  Change theme", ":silent Telescope colorscheme<CR>"),
    }
    -- Send config to alpha
    alpha.setup(dashboard.opts)

    -- Disable folding on alpha buffer
    vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
  end,
}
