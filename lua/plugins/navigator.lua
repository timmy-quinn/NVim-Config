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
        -- Alternatively, I can setup WezTerm to properly pass the key calls t neovim.
        {'<A-h>', '<CMD>NavigatorLeft<CR>', mode = {'t'}},
        {'<A-l>', '<CMD>NavigatorRight<CR>', mode = {'t'}},
        {'<A-k>', '<CMD>NavigatorUp<CR>', mode = {'t'}},
        {'<A-j>', '<CMD>NavigatorDown<CR>', mode = {'t'}},
        {'<A-p>', '<CMD>NavigatorPrevious<CR>', mode = {'t'}}
    },
    config = function()
        require('Navigator').setup()
    end

}
