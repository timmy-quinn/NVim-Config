vim.g.mapleader = " "
vim.diagnostic.config({virtual_text = true})
require("options")
require("keymaps")
require("config.lazy")
require("lazy").setup("plugins")
require("project_specific")
