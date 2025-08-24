return {
    -- {
    --     "mfussenegger/nvim-dap-python",
    --     lazy = true,
    --     config = function()
    --         require("dap-python").setup("python")
    --     end
    --     -- For a specific project, put this code in your .nvim/launch.lua 
    --     -- as per the project_specific.lua
    --     -- 
    --     -- Example configuration for Python 
    --     -- you will need to have debugpy installed in the venv. 
    --     -- You don't have to use the venv installed in your project if you don't 
    --     -- want to
    --     -- require("dap-python").setup("path/to/venv/python")
    --     -- local dap = require("dap")
    --     -- dap.configurations.python = {
    --     --   {
    --     --     name = "Launch file",
    --     --     type = "codelldb",
    --     --     request = "launch",
    --     --     program = vim.fn.getcwd() .. 'file_path',
    --     --     OR
    --     --     -- program = function()
    --     --       -- return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    --     --     -- end,
    --     --     cwd = '${workspaceFolder}',
    --     --     stopOnEntry = false,
    --     --   },
    --     -- }
    -- },
    {

    'mfussenegger/nvim-dap',
    dependencies = {
        {"rcarriga/nvim-dap-ui"},
        {"theHamsta/nvim-dap-virtual-text"},
        {"nvim-neotest/nvim-nio"},
        {"mfussenegger/nvim-dap-python"},
    },
    lazy = true,
    keys = {
        {'<C-g>t', function() require("dap").toggle_breakpoint() end},
        {'<C-g>b', function() require("dap").continue() end},
        {'<C-g>i', function() require("dap").step_into() end},
        {'<C-g>o', function() require("dap").step_over() end},
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")
        local widgets = require('dap.ui.widgets')
        local vtext = require('nvim-dap-virtual-text')
        require("dap-python").setup("python")


        vim.keymap.set("n", '<C-g>;', function() dap.close() dapui.close() end) 

        require("dapui").setup()
        vtext.setup()

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
    end
    }
}
