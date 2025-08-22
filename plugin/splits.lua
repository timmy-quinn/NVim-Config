

require('Navigator').setup()

vim.keymap.set({'n', 't'}, '<C-h>', '<CMD>NavigatorLeft<CR>')
vim.keymap.set({'n', 't'}, '<C-l>', '<CMD>NavigatorRight<CR>')
vim.keymap.set({'n', 't'}, '<C-k>', '<CMD>NavigatorUp<CR>')
vim.keymap.set({'n', 't'}, '<C-j>', '<CMD>NavigatorDown<CR>')
vim.keymap.set({'n', 't'}, '<C-p>', '<CMD>NavigatorPrevious<CR>')


-- Utilize smart splits, which enables seamless navigation between splits and 
-- panes in tmux, or wezterm. (Other terminals should also be supported
-- recommended mappings
-- resizing splits
-- these keymaps will also accept a range,
-- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`

-- local smart_splits = require('smart-splits')
-- smart_splits.setup({ignored_buftypes = {'quickfix', 'prompt'}, 
--     multiplexer = "wezterm"})
-- vim.keymap.set('n', '<A-h>', smart_splits.resize_left)
-- vim.keymap.set('n', '<A-j>', smart_splits.resize_down)
-- vim.keymap.set('n', '<A-k>', smart_splits.resize_up)
-- vim.keymap.set('n', '<A-l>', smart_splits.resize_right)
-- -- moving between splits
-- vim.keymap.set('n', '<C-h>', smart_splits.move_cursor_left)
-- vim.keymap.set('n', '<C-j>', smart_splits.move_cursor_down)
-- vim.keymap.set('n', '<C-k>', smart_splits.move_cursor_up)
-- vim.keymap.set('n', '<C-l>', smart_splits.move_cursor_right)
-- vim.keymap.set('n', '<C-\\>', smart_splits.move_cursor_previous)
-- -- swapping buffers between windows
-- vim.keymap.set('n', '<leader><leader>h', smart_splits.swap_buf_left)
-- vim.keymap.set('n', '<leader><leader>j', smart_splits.swap_buf_down)
-- vim.keymap.set('n', '<leader><leader>k', smart_splits.swap_buf_up)
-- vim.keymap.set('n', '<leader><leader>l', smart_splits.swap_buf_right)


-- -- resizing splits
-- -- amount defaults to 3 if not specified
-- -- use absolute values, no + or -
-- -- the functions also check for a range,
-- -- so for example if you bind `<A-h>` to `resize_left`,
-- -- then `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
-- require('smart-splits').resize_up(amount)
-- require('smart-splits').resize_down(amount)
-- require('smart-splits').resize_left(amount)
-- require('smart-splits').resize_right(amount)
-- -- moving between splits
-- -- You can override config.at_edge and
-- -- config.move_cursor_same_row via opts
-- -- See Configuration.
-- require('smart-splits').move_cursor_up() --  | 'split' | 'stop' })
-- require('smart-splits').move_cursor_down()
-- require('smart-splits').move_cursor_left()
-- require('smart-splits').move_cursor_right()
-- require('smart-splits').move_cursor_previous()
-- -- Swapping buffers directionally with the window to the specified direction
-- require('smart-splits').swap_buf_up()
-- require('smart-splits').swap_buf_down()
-- require('smart-splits').swap_buf_left()
-- require('smart-splits').swap_buf_right()
-- -- the buffer swap functions can also take an `opts` table to override the
-- -- default behavior of whether or not the cursor follows the buffer
-- require('smart-splits').swap_buf_right({ move_cursor = true })
