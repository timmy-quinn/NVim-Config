return {
    'numToStr/Navigator.nvim',
    keys = {
        {'<C-h>', '<CMD>NavigatorLeft<CR>', mode = {'n', 't'}},
        {'<C-l>', '<CMD>NavigatorRight<CR>', mode = {'n', 't'}},
        {'<C-k>', '<CMD>NavigatorUp<CR>', mode = {'n', 't'}},
        {'<C-j>', '<CMD>NavigatorDown<CR>', mode = {'n', 't'}},
        {'<C-p>', '<CMD>NavigatorPrevious<CR>', mode = {'n', 't'}}
    },
    config = function()
        require('Navigator').setup()
    end

}
