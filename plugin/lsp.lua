
-- -- lsp configuration 
-- vim.lsp.config('rust_analyzer', {
--   -- Server-specific settings. See `:help lsp-quickstart`
--   settings = {
--     ['rust-analyzer'] = {},
--   },
-- })


require("mason").setup()

require("mason-lspconfig").setup {
    ensure_installed = {
        "lua_ls",
        "rust_analyzer",
        "pyright",
        "clangd"
    },
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
}

local lspconfig = require('lspconfig')
lspconfig.lua_ls.setup({})
lspconfig.rust_analyzer.setup({})
lspconfig.pyright.setup({})
lspconfig.clangd.setup({})

vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
vim.keymap.set('n', "gd", vim.lsp.buf.definition, {})
vim.keymap.set({'n', 'v'}, '<leader>ca', vim.lsp.buf.code_action, {})


