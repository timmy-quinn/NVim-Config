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
    Plug 'dense-analysis/ale' " linters 
    Plug 'neoclide/coc.nvim' " intelligent autocomplete, support for LSP, snippets and various autocompletion plugin
    Plug 'neovim/nvim-lspconfig' "Language server protocol
    Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' } " fuzzy finder                                
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " Syntax and code analysis
    Plug 'p00f/nvim-ts-rainbow' "Uses tree-sitter to highlight matching parentheses
    Plug 'nvim-lualine/lualine.nvim'
    Plug 'tpope/vim-speeddating' "quickly adjust dates using <C-a>, <C-x>
    Plug 'rust-lang/rust.vim'
    Plug 'vim-scripts/c.vim'
    Plug 'morhetz/gruvbox' " Gruvbox: Color Scheme


    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/nvim-cmp'

    " For vsnip users.
    Plug 'hrsh7th/cmp-vsnip'
    Plug 'hrsh7th/vim-vsnip'


call plug#end()
    "Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
    " Plug 'kyazdani42/nvim-web-devicons' " Optional, for file icons
    "
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

"configure coc, 
let g:coc_global_extensions = ['coc-clangd']
let g:clangd_install_prefix = '/usr/'
let g:clangd_command = ['clangd',
\   '--clang-tidy',
\   '--background-index',
\   '--header-insertion-decorators=0',
\   '--completion-style=detailed']
 
nnoremap <silent> K :call <sid>show_documentation()<cr>

" Found in the github.com/neoclide/coc.nvim repo
imap <silent><expr> <C-/>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

autocmd CursorHoldI * silent! call coc#refresh()

function! s:show_documentation()
    if index(['vim', 'help'], &filetype) >= 0
        execute 'help ' . expand('<cword>')
    elseif &filetype ==# 'tex'
        VimtexDocPackage
    else
        call CocAction('doHover')
    endif
endfunction

lua << EOF

vim.lsp.config('rust_analyzer', {
  -- Server-specific settings. See `:help lsp-quickstart`
  settings = {
    ['rust-analyzer'] = {},
  },
})


require('lualine').setup {
  options = {
    theme = {
      visual = { c = {fg = '#ffffff', bg = '#000000'}},
      normal = { c = {fg = '#000000', bg = '#00ff00'}},
      insert = { c = {fg = '#000000', bg = '#ff0000'}},
      replace = { c = {fg = '#ffffff', bg = '#0000ff'}},
    },
    section_separators = '',
    component_separators = '',
  },
}
EOF
