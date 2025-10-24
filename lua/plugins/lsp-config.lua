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
    { "folke/neodev.nvim", 
        opts = {}, 
        config = function()
            require("neodev").setup({})
        end 
    },
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        config = function()
            vim.lsp.enable('lua_ls')
            vim.lsp.enable('pyright')
            vim.lsp.enable('clangd')

            vim.lsp.config('clangd', {cmd = {'clangd', '--background-index', '--query-driver=C:\\Program Files (x86)\\GNU Tools Arm Embedded\\9 2019-q4-major\\bin\\arm-none-eabi-gcc-9.2.1.exe'}})

            vim.lsp.config('lua_ls',
                {cmd = { "lua-language-server" },
                    settings = {
                        Lua = {
                            runtime = { version = "LuaJIT" },
                            diagnostics = { globals = { "vim" } },
                            workspace = {
                                library = {
                                    vim.env.VIMRUNTIME,
                                    vim.fn.expand("$VIMRUNTIME/lua"),
                                    vim.fn.stdpath("config") .. "/lua",
                                },
                                checkThirdParty = false,
                            },
                            telemetry = { enable = false },
                        },
                    },
                }
            )

            -- vim.lsp.config('lua_ls', 

            -- require('lspconfig').lua_ls.setup {
            --   settings = {
            --     Lua = {
            --       runtime = {
            --         -- Tell the language server which version of Lua you're using (most likely LuaJIT for Neovim)
            --         version = 'LuaJIT',
            --         -- Setup your lua path
            --         path = vim.split(package.path, ';'),
            --       },
            --       diagnostics = {
            --         -- Get the language server to recognize the `vim` global
            --         globals = {'vim'},
            --       },
            --       workspace = {
            --         -- Make the server aware of Neovim runtime files
            --         library = {
            --           vim.env.VIMRUNTIME,
            --           -- For lazy.nvim or packer setups, add your plugin paths here:
            --           -- "${3rd}/luv/library"
            --           -- "${3rd}/busted/library",
            --           [vim.fn.expand('$VIMRUNTIME/lua')] = true,
            --           [vim.fn.stdpath('config') .. '/lua'] = true,
            --         },
            --         checkThirdParty = false, -- Avoids prompts about third-party libraries
            --       },
            --       telemetry = {
            --         enable = false,
            --       },
            --     },
            --   },
            -- }
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
