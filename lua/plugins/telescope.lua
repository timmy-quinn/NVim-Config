local get_selection = function()
    return vim.fn.getregion(vim.fn.getpos ".", vim.fn.getpos "v", { mode = 'v' })
end


return {
	'nvim-telescope/telescope.nvim',
	tag = '0.1.8',
	dependencies = {'nvim-lua/plenary.nvim'},
    keys = {
        {'<leader>ff', function() require('telescope.builtin').find_files() end, { desc = '[F]ind [F]iles' }},
        {'<leader>ff', function() require('telescope.builtin').find_files {default_text = table.concat(get_selection())} end, mode = 'v', { desc = '[F]ind [F]iles' }},
        {'<leader>fh', function() require('telescope.builtin').find_files({hidden = true}) end,  { desc = '[F]ind [H]idden Files' }},
        {'<leader>fh', function() require('telescope.builtin').find_files({hidden = true, no_ignore=true}) end,  { desc = '[F]ind [H]idden Files' }},
        {'<leader>fg', function() require('telescope.builtin').live_grep() end,  { desc = '[F]ind by [G]rep' }},
        {'<leader>fg', function() require('telescope.builtin').live_grep {default_text = table.concat(get_selection())} end, mode = 'v', { desc = '[F]ind by [G]rep' }},
        {'<leader>fb', function() require('telescope.builtin').buffers() end,    { desc = '[F]ind [B]uffers' }},
        {'<leader>fp', function() require('telescope.builtin').help_tags() end,  { desc = '[F]ind Hel[p]' }},
        {'<leader>fk', function() require('telescope.builtin').keymaps() end,  { desc = '[F]ind [K]eymaps' }},
        {'<leader>fn', function() require('telescope.builtin').lsp_document_symbols({symbols='function'}) end, {desc = '[F]ind Functio[n]s'}},
    },
	config = function()
		require('telescope').setup({})
	end
}


