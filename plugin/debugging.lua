-- nvim-dap is supposedly better in embedded than vimspector
local dap = require("dap")
local dapui = require("dapui")

require("dapui").setup()

vim.keymap.set('n', '<C-g>t', dap.toggle_breakpoint, {})
vim.keymap.set('n', '<C-g>j', dap.continue, {})
vim.keymap.set('n', '<C-g>i', dap.step_into, {})
vim.keymap.set('n', '<C-g>o', dap.step_over, {})


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

dap.configurations.c = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
  },
}

dap.configurations.cpp = dap.configurations.c
dap.configurations.rust = dap.configurations.c

-- I believe this just sets it up so that the ui is opened during debugging
-- and closed afterwards 
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
