return {
    {
        "williamboman/mason.nvim", 
        cmd = "Mason",
        config = function()
            require("mason").setup()
        end,
    },
    -- {
    --     "williamboman/mason-lspconfig.nvim", 
    --     lazy = false, 
    --     opts = {
    --         auto_install = true,
    --     },
    --     config = function()
    --         require("mason-lspconfig").setup {
    --             ensure_installed = {
    --                 "lua_ls",
    --                 "rust_analyzer",
    --                 "pyright",
    --                 "clangd"
    --             },
    --             -- THESE must be false / NIL to avoid duplicate 
    --             -- More info here: 
    --             -- https://github.com/rachartier/tiny-inline-diagnostic.nvim/issues/131#issuecomment-3242980586
    --             automatic_installation = false,
    --             automatic_setup = false,
    --             automatic_enable = false,
    --             handlers = nil,
    --         }
    --     end
    -- },
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        config = function()
            -- vim.lsp.enable('lua_ls')
            -- vim.lsp.enable('pyright')
            -- vim.lsp.enable('clangd')
            -- vim.lsp.config('clangd', {cmd = {'clangd', '--background-index', '-ferror-limit=0', '--query-driver=C:\\Program Files (x86)\\GNU Tools Arm Embedded\\9 2019-q4-major\\bin\\arm-none-eabi-gcc-9.2.1.exe'}})
            

            vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
            vim.keymap.set('n', "gd", vim.lsp.buf.definition, {})
            vim.keymap.set({'n', 'v'}, '<leader>ca', vim.lsp.buf.code_action, {})
            vim.keymap.set({'n', 'v'}, '<leader>h', ':ClangdSwitchSourceHeader<CR>')


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
