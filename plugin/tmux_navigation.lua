-- nvim-tmux-navigation enables you to seemlessly move between tmux and nvim 
-- using a shared set of commands (so long as you set the keymaps to function 
-- in the same way
--
-- https://github.com/alexghergh/nvim-tmux-navigation
--
--
local nvim_tmux_nav =  require('nvim-tmux-navigation')

vim.keymap.set('n', "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
vim.keymap.set('n', "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
vim.keymap.set('n', "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
vim.keymap.set('n', "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
vim.keymap.set('n', "<C-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive)
vim.keymap.set('n', "<C-Space>", nvim_tmux_nav.NvimTmuxNavigateNext)
