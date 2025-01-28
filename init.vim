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

set tabstop=4
set shiftwidth=4
set expandtab
set autoindent

" Disable swap files. Prevents creation of temp backup files
set noswapfile 

set encoding=utf-8

call plug#begin()
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' } " fuzzy finder                                
Plug 'morhetz/gruvbox' " Gruvbox: Color Scheme
Plug 'nvim-lualine/lualine.nvim'
"Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
" Plug 'kyazdani42/nvim-web-devicons' " Optional, for file icons
call plug#end()

"colorscheme catppuccin-macchiato
"vim.cmd.colorscheme "catppuccin"

let g:gruvbox_transparent_bg = 1
let g:gruvbox_bold = 1
let g:gruvbox_underline = 1
let g:gruvbox_undercurl = 1
let g:gruvbox_italic = 1
let g:gruvbox_termcolors = 124
colorscheme gruvbox



lua << EOF
require('lualine').setup {
  options = {
    theme = 'auto', -- Automatically sets the color based on mode
    section_separators = '',
    component_separators = '',
  }
}
EOF


lua << EOF
require('lualine').setup {
  options = {
    theme = {
      visual = { c = {fg = '#ffffff', bg = '#000000'}},
      normal = { c = {fg = '#000000', bg = '#00ff00'}},
      insert = { c = {fg = '#000000', bg = '#ff0000'}},
      replace = { c = {fg = '#ffffff', bg = '#0000ff'}},
    },
  },
}
EOF
