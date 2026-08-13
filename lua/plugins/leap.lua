return {
    {
        -- leap around the nvim buffer using two character pairs
        url = 'https://codeberg.org/andyg/leap.nvim',
        config = function()
            -- require('leap').set_default_mappings()
            vim.keymap.set({'n', 'x', 'o'}, 's', '<Plug>(leap)')
            -- vim.keymap.set('n',             'S', '<Plug>(leap-from-window)')
            require('leap').opts.safe_labels = {}
        end
    }
}
