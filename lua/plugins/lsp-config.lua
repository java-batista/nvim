return {
  {
    "williamboman/mason.nvim",
    tag = "v1.11.0",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    tag = "v2.0.0-rc.1",
    lazy = false,
    opts = {
      --auto_install = true,
      ensure_installed = { "lua_ls", "clangd", "pylsp", "arduino_language_server"  },
    },
  },
  {
    "neovim/nvim-lspconfig",
    tag = "v1.8.0",
    lazy = false,
    config = function()
      --local capabilities = require('cmp_nvim_lsp').default_capabilities()

      local lspconfig = require("lspconfig")        
               
      lspconfig.lua_ls.setup({
        --capabilities = capabilities
      })
      lspconfig.clangd.setup({
        --capabilities = capabilities
      })
      lspconfig.pylsp.setup({
        --capabilities = capabilities
      })
      lspconfig.arduino_language_server.setup({
        --capabilities = capabilities
      })

      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
    end,
  },
}
