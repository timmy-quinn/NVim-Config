-- Autoload .nvim/launch.lua if it exists
vim.keymap.set('n', '<leader>after', function() print('after loaded') end)
local launch_config = vim.fn.getcwd() .. '/.nvim/launch.lua'
if vim.fn.filereadable(launch_config) == 1 then
 dofile(launch_config)
end
