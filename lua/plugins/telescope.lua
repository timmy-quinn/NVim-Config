return {
	'nvim-telescope/telescope.nvim', 
	tag = '0.1.8',
	dependencies = {'nvim-lua/plenary.nvim'},
    keys = {
        {'<leader>ff', function() require('telescope.builtin').find_files() end, { desc = '[F]ind [F]iles' }},
        {'<leader>fh', function() require('telescope.builtin').find_files({hidden = true}) end,  { desc = '[F]ind [H]idden Files' }},
        {'<leader>fg', function() require('telescope.builtin').live_grep() end,  { desc = '[F]ind by [G]rep' }},
        {'<leader>fb', function() require('telescope.builtin').buffers() end,    { desc = '[F]ind [B]uffers' }},
        {'<leader>fp', function() require('telescope.builtin').help_tags() end,  { desc = '[F]ind Hel[p]' }},
        {'<leader>fk', function() require('telescope.builtin').keymaps() end,  { desc = '[F]ind [K]eymaps' }},
    },
	config = function()
		require('telescope').setup({})
	end
}


