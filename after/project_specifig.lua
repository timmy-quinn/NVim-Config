
-- Autoload .nvim/launch.lua if it exists
local launch_config = vim.fn.getcwd() .. '/.nvim/launch.lua'
if vim.fn.filereadable(launch_config) == 1 then
 dofile(launch_config)
end
