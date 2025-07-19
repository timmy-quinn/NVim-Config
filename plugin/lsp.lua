
-- lsp configuration 
vim.lsp.config('rust_analyzer', {
  -- Server-specific settings. See `:help lsp-quickstart`
  settings = {
    ['rust-analyzer'] = {},
  },
})


require("mason").setup()

require("mason-lspconfig").setup {
    ensure_installed = {"lua_ls", "rust-analyzer" }, 
}
