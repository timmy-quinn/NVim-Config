return {
    'nvim-mini/mini.nvim',
    version = false,
    config = function()
        local opts = {
            mappings = {
                add = 'na', -- Add surrounding in Normal and Visual modes
                delete = 'nd', -- Delete surrounding
                find = 'nf', -- Find surrounding (to the right)
                find_left = 'nF', -- Find surrounding (to the left)
                highlight = 'nh', -- Highlight surrounding
                replace = 'nr', -- Replace surrounding
                suffix_last = 'l', -- Suffix to search with "prev" method
                suffix_next = 'n', -- Suffix to search with "next" method
              },

        }
        require('mini.surround').setup(opts)
    end
}
