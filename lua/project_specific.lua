-- Autoload .nvim/launch.lua if it exists
-- vim.keymap.set('n', '<leader>after', function() print('after loaded') end)
local dir = vim.fn.getcwd()
local parent = "" 
local project_config = '/.nvim/launch.lua'
while parent ~= dir do
    local launch_config = dir .. project_config
    if vim.fn.filereadable(launch_config) == 1 then
        dofile(launch_config)
    end
    parent = dir
    dir = vim.fs.dirname(dir)
end
