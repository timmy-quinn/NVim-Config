return {
	'nvim-telescope/telescope.nvim', 
	tag = '0.1.8',
	dependencies = {'nvim-lua/plenary.nvim'},
	config = function()
		require('telescope').setup({})
		local builtin = require('telescope.builtin')
		vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles' })
		vim.keymap.set('n', '<leader>fh', function() builtin.find_files({hidden = true}) end,  { desc = '[F]ind [H]idden Files' })
		vim.keymap.set('n', '<leader>fg', builtin.live_grep,  { desc = '[F]ind by [G]rep' })
		vim.keymap.set('n', '<leader>fb', builtin.buffers,    { desc = '[F]ind [B]uffers' })
		vim.keymap.set('n', '<leader>fp', builtin.help_tags,  { desc = '[F]ind Hel[p]' })
		vim.keymap.set('n', '<leader>fk', builtin.keymaps,  { desc = '[F]ind [K]eymaps' })
	end
}


