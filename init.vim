syntax on
set cursorline
highlight CursorLine cterm=NONE ctermbg=240
set scrolloff=3

set nowrap
set number
set relativenumber
set clipboard=unnamedplus
set ttyfast

set ignorecase

set clipboard=unnamedplus
set colorcolumn=80

set tabstop=4
set shiftwidth=4
set expandtab
set autoindent

" Disable swap files. Prevents creation of temp backup files
set noswapfile 
set encoding=utf-8

" """""" KEYBINDINGS """""""""
" Convenience 
inoremap jj <Esc>
noremap o o<Esc>
nnoremap ; :
vnoremap ; :

" set <leader> key 
let mapleader = " "

" Buffer navigation 
noremap <leader>j :bn<CR> 
vnoremap <leader>j :bn<CR> 

noremap <leader>k :bp<CR> 
vnoremap <leader>k :bp<CR>

nnoremap <leader>q :bd<CR>
vnoremap <leader>q :bd<CR>

" mappings prevent pasting and copying to overwrite clipboard
vnoremap p "_dp

nnoremap d "_d
vnoremap d "_d
xnoremap d "_d

nnoremap D d
vnoremap D d
xnoremap D d

vnoremap DD dd



call plug#begin()
    Plug 'nvim-lua/plenary.nvim'

    Plug 'dense-analysis/ale' " linters 

    " Searching 
    Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' } " fuzzy finder                                

    " enhances code navigation, 
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " Syntax and code analysis

    " Convenience, navigation, editing 
    Plug 'tpope/vim-speeddating' "quickly adjust dates using <C-a>, <C-x>
    Plug 'ggandor/leap.nvim' " jump to place using two character search

    " Appearance 
    Plug 'morhetz/gruvbox' " Gruvbox: Color Scheme
    Plug 'nvim-lualine/lualine.nvim'
    Plug 'p00f/nvim-ts-rainbow' "Uses tree-sitter to highlight matching parentheses
    Plug 'goolord/alpha-nvim' " Startup screen
    Plug 'nvim-tree/nvim-web-devicons'
    " Plug 'ryanoasis/vim-devicons' Icons without colours
    Plug 'akinsho/bufferline.nvim', { 'tag': '*' }

    " Install lsp configuration stuff 
    Plug 'williamboman/mason.nvim'
    Plug 'mason-org/mason-lspconfig.nvim'
    
    " Enriched language support, syntax highlighting, etc. 
    " This setup is described in https://github.com/hrsh7th/nvim-cmp
    Plug 'neovim/nvim-lspconfig' " Widely used language server protocol 

    Plug 'hrsh7th/cmp-nvim-lsp' 
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/nvim-cmp'

    " For vsnip users.
    Plug 'hrsh7th/cmp-vsnip'
    Plug 'hrsh7th/vim-vsnip'

    " Language specific
    Plug 'rust-lang/rust.vim'
    Plug 'vim-scripts/c.vim'
    
    " comment functionality with gc 
    Plug 'tpope/vim-commentary'
    
    " Debugging 
    Plug 'mfussenegger/nvim-dap'
    Plug 'nvim-neotest/nvim-nio'
    Plug 'rcarriga/nvim-dap-ui'

call plug#end()


" APPEARANCE 
let g:gruvbox_transparent_bg = 1
let g:gruvbox_bold = 1
let g:gruvbox_underline = 1
let g:gruvbox_undercurl = 1
let g:gruvbox_italic = 1
let g:gruvbox_termcolors = 124
colorscheme gruvbox

lua << EOF

vim.o.exrc = true

-- Setup nvim-leap
require('leap').set_default_mappings()

-- Lualine configuration 
vim.o.showmode = false
local custom_gruvbox = require('lualine.themes.gruvbox')

-- This switches around the configurations. 
-- Note: if you run :source, then the colors will be further flipped
vim.opt.termguicolors = true
require("bufferline").setup{}

custom_gruvbox.visual, custom_gruvbox.normal, custom_gruvbox.insert = custom_gruvbox.normal, custom_gruvbox.insert, custom_gruvbox.visual


require('lualine').setup {
  options = {
    theme = custom_gruvbox,
    section_separators = '',
    component_separators = '',
  },
  tabline = {
      lualine_c = {
          {
          'buffers',
          max_length = vim.o.columns*0.7,
          show_filename_only = true, 
          show_modified_status=true, 
            
          symbols = {
            modified = ' ●',      -- Text to show when modified
          }, 
        }
      }, 
      lualine_z = {'tabs'}
  }

}

vim.api.nvim_set_hl(0, 'lualine_buffer_active', {link = 'Visual'}) 
EOF

