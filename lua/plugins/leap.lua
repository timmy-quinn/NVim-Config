return {
    {
        -- leap around the nvim buffer using two character pairs
        'ggandor/leap.nvim', 
        config = function()
            require('leap').set_default_mappings()
        end
    }
}
