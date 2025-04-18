local utils = require("utils")

return {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    "williamboman/mason.nvim",       -- package manager for LSP servers
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lsp",          -- provides extra capabilities for autocompletion
    "artemave/workspace-diagnostics.nvim",
    "nvim-telescope/telescope.nvim", -- for LSP pickers (used in on_attach)
    "towolf/vim-helm",               -- required to make helm-ls work
  },
  config = function()
    local lspconfig = require("lspconfig")
    local mason_lspconfig = require("mason-lspconfig")
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    mason_lspconfig.setup()
    mason_lspconfig.setup_handlers({
      function(server_name)
        lspconfig[server_name].setup({
          capabilities = capabilities,
          on_attach = utils.lsp.on_attach,
        })
      end,
    })
  end,
}
