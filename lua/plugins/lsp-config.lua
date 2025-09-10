return {
    {
        "williamboman/mason.nvim", 
        cmd = "Mason",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim", 
        lazy = false, 
        opts = {
            auto_install = true,
        },
        config = function()
            require("mason-lspconfig").setup {
                ensure_installed = {
                    "lua_ls",
                    "rust_analyzer",
                    "pyright",
                    "clangd"
                },
                -- THESE must be false / NIL to avoid duplicate 
                -- More info here: 
                -- https://github.com/rachartier/tiny-inline-diagnostic.nvim/issues/131#issuecomment-3242980586
                automatic_installation = false,
                automatic_setup = false,
                automatic_enable = false,
                handlers = nil,
            }
        end
    },
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        config = function()

            local lspconfig = require('lspconfig')
            lspconfig.lua_ls.setup({})
            lspconfig.rust_analyzer.setup({
                ['rust-analyzer'] = {
                    -- diagnostics = {
                    --     virtualText = false,
                    -- },
                },
            })
            lspconfig.pyright.setup({})
            lspconfig.clangd.setup({})
            -- lspconfig.clangd.setup({
            --     cmd = {'clangd', '--background-index', '--clang-tidy'}
            -- }
            -- )

            vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
            vim.keymap.set('n', "gd", vim.lsp.buf.definition, {})
            vim.keymap.set({'n', 'v'}, '<leader>ca', vim.lsp.buf.code_action, {})

            vim.keymap.set({'n', 'v'}, '<leader>s', ':ClangdSwitchSourceHeader<CR>')


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
            --
        end 
    }
}
