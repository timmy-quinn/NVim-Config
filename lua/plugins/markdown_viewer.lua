return {
    "toppair/peek.nvim",
    -- event = { "VeryLazy" },
    build = "deno task --quiet build:fast",
    config = function()
        peek = require("peek")
        peek.setup()
        vim.api.nvim_create_user_command("PeekOpen", peek.open, {})
        vim.api.nvim_create_user_command("PeekClose", peek.close, {})
        vim.keymap.set('n', '<leader>mdc', peek.close, {})         
        vim.keymap.set('n', '<leader>mdo', peek.open, {})         
    end,
}
