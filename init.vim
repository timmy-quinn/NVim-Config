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

" This is the <leader> key 
" (leader key is not <C> lol>
let mapleader = " "


nnoremap ; :
vnoremap ; :

" mappings prevent pasting and copying to overwrite clipboard
vnoremap p "_dp

nnoremap d "_d
vnoremap d "_d
xnoremap d "_d

nnoremap D d
vnoremap D d
xnoremap D d

vnoremap DD dd



" Keybindings
inoremap jj <Esc>
noremap o o<Esc>

" remap this to allow vim-leap to use s 
" noremap s /S

set tabstop=4
set shiftwidth=4
set expandtab
set autoindent

" Disable swap files. Prevents creation of temp backup files
set noswapfile 

set encoding=utf-8

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


call plug#end()


" Appearance 
let g:gruvbox_transparent_bg = 1
let g:gruvbox_bold = 1
let g:gruvbox_underline = 1
let g:gruvbox_undercurl = 1
let g:gruvbox_italic = 1
let g:gruvbox_termcolors = 124
colorscheme gruvbox

lua << EOF
require('leap').set_default_mappings()

-- Gruvbox configuration 
local custom_gruvbox = require'lualine.themes.gruvbox'
require('lualine').setup {
  options = {
    theme = custom_gruvbox,
    section_separators = '',
    component_separators = '',
  },
}
EOF



