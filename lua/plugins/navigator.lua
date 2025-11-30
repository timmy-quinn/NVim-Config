return {
    'numToStr/Navigator.nvim',
    keys = {
        {'<C-h>', '<CMD>NavigatorLeft<CR>', mode = {'n'}},
        {'<C-l>', '<CMD>NavigatorRight<CR>', mode = {'n'}},
        {'<C-k>', '<CMD>NavigatorUp<CR>', mode = {'n'}},
        {'<C-j>', '<CMD>NavigatorDown<CR>', mode = {'n'}},
        {'<C-p>', '<CMD>NavigatorPrevious<CR>', mode = {'n'}},

        -- On windows, using a windows terminal, using C-direction may cause issues
        -- Windows terminals will interpret C-j as newline for example. 
        -- NeoVim apparently doesn't even see the key press really
        -- Using C-S-direction was the best solution I've been able to find
        -- It may be worth considering using a different set of keymappings in 
        -- general
        {'<C-S-h>', '<CMD>NavigatorLeft<CR>', mode = {'t'}},
        {'<C-S-l>', '<CMD>NavigatorRight<CR>', mode = {'t'}},
        {'<C-S-k>', '<CMD>NavigatorUp<CR>', mode = {'t'}},
        {'<C-S-j>', '<CMD>NavigatorDown<CR>', mode = {'t'}},
        {'<C-S-p>', '<CMD>NavigatorPrevious<CR>', mode = {'t'}}
    },
    config = function()
        require('Navigator').setup()
    end

}
