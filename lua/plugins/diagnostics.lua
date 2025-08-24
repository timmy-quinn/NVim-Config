return {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy", 
    priority = 1000,
    config = function()
        require('tiny-inline-diagnostic').setup({
            options = {
                show_source = {
                    enabled = true, 
                    if_many = false
                }
            },
        })
        vim.diagnostic.config({virtual_text = false})
    end
}
