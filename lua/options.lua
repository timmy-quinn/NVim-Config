local opt = vim.opt 

opt.clipboard = "unnamedplus"

-- disable netrw at the very start of your init.lua
-- this is the default nvim lua file tree thingy 
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- optionally enable 24-bit colour
vim.opt.termguicolors = true

opt.syntax = "on"
-- highlight CursorLine cterm=NONE ctermbg=240
opt.cursorline = true
opt.scrolloff=3
opt.cursorline = true

	
vim.wo.wrap = false 
opt.number = true
opt.relativenumber = true
opt.ttyfast = true

opt.ignorecase = true
opt.smartcase = true

opt.colorcolumn="80"

opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true

-- " This should ensure that the gutter on the left is always open. 
-- " I find it annoying when the gutter appears and disappears as 
-- " for example happens when the lsp is detecting errors and warnings
-- " in the code
opt.signcolumn="yes"

-- " Disable swap files. Prevents creation of temp backup files
opt.swapfile = false 
opt.encoding = "utf-8"

-- Neovim will search for the following files in the 
-- current directory
vim.o.exrc = true


-- vim.diagnostic.config({
--     virtual_text = false,
--     underline = true}
-- )

