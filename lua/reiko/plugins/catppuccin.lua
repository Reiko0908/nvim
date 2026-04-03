return {
  "catppuccin/nvim", 
  name = "catppuccin", 
  priority = 1000,
  lazy = false,
  config = function()
    require("catppuccin").setup({
      flavour = "auto", -- latte, frappe, macchiato, mocha
      background = { -- :h background
        light = "latte",
        dark = "macchiato",
      },
      transparent_background = true, -- disables setting the background color.\
      float = {
        transparent = true, -- enable transparent floating windows
        solid = true, -- use solid styling for floating windows, see |winborder|
      },
      show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
      term_colors = true, -- sets terminal colors (e.g. `g:terminal_color_0`)
      dim_inactive = {
        enabled = false, -- dims the background color of inactive window
        shade = "dark",
        percentage = 0.15, -- percentage of the shade to apply to the inactive window
      },
      styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        loops = {},
        functions = { "bold" },
        keywords = { "bold" },
        strings = {},
        variables = {},
        numbers = {},
        booleans = { "bold" },
        properties = {},
        types = { "bold" },
        operators = {},
      },
      color_overrides = {},
      custom_highlights = {},
      default_integrations = true,
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        notify = false,
        mini = {
          enabled = true,
          indentscope_color = "",
        },
        telescope = {
          enabled = true,
        },
        mason = true,
        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
      },
      native_lsp = {
        enabled = true,
        virtual_text = {
          errors = { "italic" },
          hints = { "italic" },
          warnings = { "italic" },
          information = { "italic" },
        },
        underlines = {
          errors = { "underline" },
          hints = { "underline" },
          warnings = { "underline" },
          information = { "underline" },
        },
      },
    })
    vim.cmd.colorscheme "catppuccin"
  end,
}
