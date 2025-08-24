-- ok, so here we define a function to replace the existing on_attach function 
-- this plugin uses 
local function my_on_attach(bufnr)
    local nvim_tree = require "nvim-tree.api"

    -- provide the options requierd for the keymappings
    -- nvim-tree uses bufnr, which means it operates in its own special buffer
    -- and these keymappings will apply to just that buffer, I believe 
    local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- to see existing default keymappings, use --help nvim-tree-mappings-default
    nvim_tree.config.mappings.default_on_attach(bufnr)
    -- unmap, and C-e and remap that function to C-p
    vim.keymap.del('n', '<C-e>', {buffer = bufnr})
    vim.keymap.set('n', '<C-p>', nvim_tree.tree.change_root_to_parent, opts('Up'))

end

return {
    "nvim-tree/nvim-tree.lua",
    cmd = {"NvimTreeToggle", "NvimTreeFocus", "NvimTreeFindFileToggle"}, 
    keys = {
        {"<C-e>", "<cmd>NvimTreeToggle<CR>", desc = "Toggle file explorer"},
    },
    config = function()
        require("nvim-tree").setup {
            view = {
                side = "right",
            },
            on_attach = my_on_attach,
            -- make C-e toggle the file explorer 
            -- vim.keymap.set('n', '<C-e>', ':NvimTreeToggle<CR>', {silent=true, noremap=true })
        }
    end
}
