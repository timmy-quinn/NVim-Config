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

" Keybindings
inoremap jj <Esc>

set tabstop=4
set shiftwidth=4
set expandtab
set autoindent

" Disable swap files. Prevents creation of temp backup files
set noswapfile 

call plug#begin()
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' } " fuzzy finder                                
Plug 'morhetz/gruvbox' " Gruvbox: Color Scheme
Plug 'nvim-lualine/lualine.nvim'
" Plug 'kyazdani42/nvim-web-devicons' " Optional, for file icons
call plug#end()

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
