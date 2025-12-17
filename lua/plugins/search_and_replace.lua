-- return {
--     "nvim-pack/nvim-spectre",
--     keys = {
--         {'<leader>S', '<cmd>lua require("spectre").toggle()<CR>', mode = {'n'}, { desc = "Toggle Spectre" }},
--         {'<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', mode = {'n'}, { desc = "Search current word" }},
--         {'<leader>sw', '<esc><cmd>lua require("spectre").open_visual()<CR>', mode = {'v'}, { desc = "Search current word" }},
--         {'<leader>sp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', mode = {'n'}, { desc = "Search on current file" }},
--     }
-- }
return {
    'MagicDuck/grug-far.nvim',
    -- Note (lazy loading): grug-far.lua defers all it's requires so it's lazy by default
    -- additional lazy config to defer loading is not really needed...
    config = function()
      -- optional setup call to override plugin options
      -- alternatively you can set options with vim.g.grug_far = { ... }
      require('grug-far').setup({
        -- options, see Configuration section below
        -- there are no required options atm
      });
      vim.keymap.set({'n'},"<leader>gf", "<CMD>GrugFar<CR>",   {})
    end
  }
