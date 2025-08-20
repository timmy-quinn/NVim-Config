-- nvim-dap is supposedly better in embedded than vimspector
local dap = require("dap")
local dapui = require("dapui")
local widgets = require('dap.ui.widgets')
local vtext = require('nvim-dap-virtual-text')



-- If using the above, then `python3 -m debugpy --version`
-- must work in the shell
require("dap-python").setup("python")

require("dapui").setup()
vtext.setup()

vim.keymap.set('n', '<C-g>t', dap.toggle_breakpoint, {})
vim.keymap.set('n', '<C-g>b', dap.continue, {})
vim.keymap.set('n', '<C-g>i', dap.step_into, {})
vim.keymap.set('n', '<C-g>o', dap.step_over, {})
vim.keymap.set('n', '<C-g>;', function() dap.close() dapui.close() end, {})

-- Configure key map for display values when hovering 
vim.keymap.set({'n', 'v'}, '<Leader>dh', widgets.hover )
vim.keymap.set({'n', 'v'}, '<Leader>dp', widgets.preview)

vim.keymap.set('n', '<Leader>df', function()
  widgets.centered_float(widgets.frames)
end)

vim.keymap.set('n', '<Leader>ds', function()
  widgets.centered_float(widgets.scopes)
end)

-- you can find installation and config instructions in 
-- github.com/mfussenegger/nvim-dap under nvim-dap 
-- Debug-Adapter Installation & configurations
-- can find instructions for other languages as well (such as python) 

-- configure codelldb for debugging c/c++/Rust
-- uses the recommended configurations found here: 
-- https://codeberg.org/mfussenegger/nvim-dap/wiki/C-C---Rust-(via--codelldb)
dap.adapters.codelldb = {
  type = "executable",
  command = vim.fn.expand("~/.local/share/nvim/mason/packages/codelldb/codelldb") -- or if not in $PATH: " -- /absolute/path/to/codelldb"
  -- On windows you may have to uncomment this:
  -- detached = false,
}

-- Stop on exceptions
-- you could configure this for just python using dap.defaults.python.exception_breakpoints
dap.defaults.fallback.exception_breakpoints = {'uncaught'}


-- Setting up the dap-ui 
--
--

-- This is done by default 
-- dapui.setup({
--     mappings = {
--         open = "o", 
--         remove = {"d", "Del"}, -- remove
--         -- expand = {"<CR>", "<2-LeftMouse>" },
        
--     },
-- })

-- Set it up so that the gui is opened at the start of a debug session 
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end


for _, config in ipairs(dap.configurations.python) do
  config.console = 'integratedTerminal'
end

-- For a specific project, put this code in your .nvim/launch.lua 
-- as per the project_specific.lua
-- 
-- Example configuration for Python 
-- you will need to have debugpy installed in the venv. 
-- You don't have to use the venv installed in your project if you don't 
-- want to
-- require("dap-python").setup("path/to/venv/python")
-- local dap = require("dap")
-- dap.configurations.python = {
--   {
--     name = "Launch file",
--     type = "codelldb",
--     request = "launch",
--     program = vim.fn.getcwd() .. 'file_path',
--     OR
--     -- program = function()
--       -- return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
--     -- end,
--     cwd = '${workspaceFolder}',
--     stopOnEntry = false,
--   },
-- }
--
--
-- Example configurations for C, C++, and Rust
-- local dap = require("dap")
-- dap.configurations.c = {
--   {
--     name = "Launch file",
--     type = "codelldb",
--     request = "launch",
--     program = vim.fn.getcwd() .. 'file_path',
--     OR
--     -- program = function()
--       -- return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
--     -- end,
--     cwd = '${workspaceFolder}',
--     stopOnEntry = false,
--   },
-- }

-- dap.configurations.cpp = dap.configurations.c
-- dap.configurations.rust = dap.configurations.c
