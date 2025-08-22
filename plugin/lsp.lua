
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

vim.diagnostic.config({
    virtual_text = true,
    underline = true}
)

local lspconfig = require('lspconfig')
lspconfig.lua_ls.setup({})
lspconfig.rust_analyzer.setup({
    ['rust-analyzer'] = {
        diagnostics = {
            virtualText = false,
        },
    },
})
lspconfig.pyright.setup({})
-- lspconfig.clangd.setup({
--     cmd = {'clangd', '--background-index', '--clang-tidy'}
-- }
-- )

vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
vim.keymap.set('n', "gd", vim.lsp.buf.definition, {})
vim.keymap.set({'n', 'v'}, '<leader>ca', vim.lsp.buf.code_action, {})


-- When using clangd, to ensure that clangd is aware of the include paths, 
-- you can use either an auto_generated compile_commands.json, or you can add 
-- the files to a .clangd file
--
-- ```c
-- CompileFlags:
--   Add: [
--     "-I", "C:\\Proj\\hi_core\\HI_Protocol\\lib\\include\\modbus", 
--     "-I", "C:\\Proj\\hi_core\\HI_Base\\lib\\include\\hi_base", 
--     "-I", "C:\\Proj\\hi_core\\HI_Base\\lib\\include", 
--   ]

