return {
    'stevearc/conform.nvim',
    config = function()

        require("conform").setup({
            format_after_save = {
                lsp_format = "never",
            },
            -- formatters = {
            --     ["clang-format"] = { 
            --         cmd = "clang-format",
            --         condition = function(self, ctx) 
            --             -- we only check the cwd. We could do a more thorough check
            --             -- but for me that isn't worth it
            --             return vim.fn.filereadable(vim.fn.getcwd() .. "/.clang-format") == 1 
            --         end,
            --     }
            -- },
            formatters_by_ft = {
                lua = { "stylua" },
                -- Conform will run multiple formatters sequentially
                -- python = { "black" }, -- Add config to toggle testing
                -- You can customize some of the format options for the filetype (:help conform.format)
                rust = { "rustfmt", lsp_format = "fallback" },
                -- c = {"clang-format"},
            }
        })


    end
}
