return {
  -- 1. Add lazydev to fix "Undefined global vim"
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },
  { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings

  -- 2. Mason Setup
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "lua_ls", "clangd", "pyright", "jdtls" },
      auto_install = true,
    },
  },

  -- 3. LSP Config
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Global diagnostic mappings
      vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
      vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end)
      vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end)
      vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

      -- CODE MOVED UP: Define on_attach BEFORE setting up servers
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
        callback = function(args)
          local bufnr = args.buf
          vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
          -- Enable completion triggered by <c-x><c-o>
          vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

          local bufopts = { noremap = true, silent = true, buffer = bufnr }
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
          vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
          vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
          vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
          vim.keymap.set("n", "<space>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, bufopts)
          vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
          vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
          vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
          vim.keymap.set("n", "<space>f", function()
            vim.lsp.buf.format({ async = true })
          end, bufopts)
        end,
      })

      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
            diagnostics = {
              globals = { "vim", "require" },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = {
              enable = false,
            },
          },
        },
      })

      vim.lsp.enable("lua_ls")
      local servers = {"clangd", "pyright"}
      -- Setup handlers
      for _, server in ipairs(servers) do
        -- Inject capabilities into the native config
        vim.lsp.config(server, {
          capabilities = capabilities,
        })
        -- Enable the server (replaces .setup())
        vim.lsp.enable(server)
      end
    end,
  },
}
