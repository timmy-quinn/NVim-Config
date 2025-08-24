
local set = vim.keymap.set

set("i", "jj", "<Esc>")
set("n", "o", "o<Esc>")

-- Enable indenting without exiting
set('v', '<', '<gv')
set('v', '>', '>gv')


set("n", ";", ":")
set("v", ";", ":")


-- Buffer navigation 
set("n", "<leader>j", ":bn<CR>") 
set("v", "<leader>j", ":bn<CR>")

set("n", "<leader>k", ":bp<CR>") 
set("v", "<leader>k", ":bp<CR>")

set("n", "<leader>q", ":bd<CR>")
set("v", "<leader>q", ":bd<CR>")


set("n", "<leader>s", "<C-w>s \"") -- Split horizontally 
set("n", "<leader>v", "<C-w>v") -- Split vertically 

-- Exit the nvim builtin terminal
set("t", "<Esc>", "<C-\\><C-n>")
set("t", "<C-q>", "<C-\\><C-n>")


-- mappings prevent pasting and copying to overwrite clipboard
set("v", "p", "\"_dP")
set("v", "P", "\"_dp")

set("n", "d", "\"_d")
set("v", "d", "\"_d")
set("x", "d", "\"_d")

set("n", "D", "d")
set("v", "D", "d")
set("x", "D", "d")

set("v", "DD", "dd")

