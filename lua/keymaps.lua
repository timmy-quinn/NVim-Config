local set = vim.keymap.set

set("i", "jj", "<Esc>")
set("n", "o", "o<Esc>")

-- Enable indenting without exiting
set('v', '<', '<gv')
set('v', '>', '>gv')


set("n", ";", ":")
set("v", ";", ":")


-- Center when navigating up and down
set("n", "<C-d>", "<C-d>zz")
set("n", "<C-u>", "<C-u>zz")


-- Buffer navigation 
set("n", "<leader>j", ":bn<CR>") 
set("v", "<leader>j", ":bn<CR>")

set("n", "<leader>k", ":bp<CR>") 
set("v", "<leader>k", ":bp<CR>")

set("n", "<leader>q", ":bd<CR>")
set("v", "<leader>q", ":bd<CR>")


set("n", "<leader>s", "<C-w>s \"") -- Split horizontally 
set("n", "<leader>v", "<C-w>v") -- Split vertically 

-- set("n", "<C-Up>", ":resize +2<CR>")
-- set("n", "<C-Down>", ":resize -2<CR>")
-- set("n", "<C-Left>", ":vertical resize -2<CR>")
-- set("n", "<C-Right>", ":vertical resize +2<CR>")

-- Exit the nvim builtin terminal
set("t", "<Esc>", "<C-\\><C-n>")
set("t", "<C-q>", "<C-\\><C-n>")

local function smart_resize(direction, amount)
  local cur_win = vim.api.nvim_get_current_win()
  local neighbor = vim.fn.winnr(direction)
  if neighbor ~= cur_win then
    if direction == 'h' then
      vim.cmd('vertical resize +' .. amount)
    elseif direction == 'l' then
      vim.cmd('vertical resize -' .. amount)
    elseif direction == 'j' then
      vim.cmd('resize -' .. amount)
    elseif direction == 'k' then
      vim.cmd('resize +' .. amount)
    end
  end
end

set('n', '<C-Right>', function() smart_resize('l', 2) end)
set('n', '<C-Left>',  function() smart_resize('h', 2) end)
set('n', '<C-Down>',  function() smart_resize('j', 2) end)
set('n', '<C-Up>',    function() smart_resize('k', 2) end)


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

