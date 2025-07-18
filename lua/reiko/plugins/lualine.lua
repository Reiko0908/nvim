return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('lualine').setup {
      options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        -- component_separators = '',
        -- section_separators = { left = '', right = '' },

        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        }
      },
      sections = {
        lualine_a = {'mode'},
        -- lualine_a = { { 'mode', separator = { left = '' }, right_padding = 2 } },
        -- lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_b = {function() return vim.fn.getcwd() end},
        -- lualine_c = {"buffers"},
        lualine_c = {'branch', 'diff', 'diagnostics'},
        lualine_x = {'encoding','fileformat','filetype'},        
        lualine_y = {'progress'},
        lualine_z = {'location'},
        -- lualine_z = {{'location', separator = { right = '' }, left_padding = 2 }}
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
      },
      tabline = {
        lualine_b = {'branch'},
        lualine_c = {
          {
            'buffers',
            show_filename_only = true,
            mode = 2,
          },
        },
        lualine_z = {'tabs'}
      },      
      theme = 'auto', 
      icons_enabled = true, 
      component_separators = { left = '', right = '' },
      section_separators = { left = '', right = '' },
      always_show_tabline = true,
      disabled_filetypes = {
        statusline = {},
        winbar = {},
      },
      refresh = {
        statusline = 100,
        tabline = 100,
        winbar = 100,
      }    
    }
  end, 
}

