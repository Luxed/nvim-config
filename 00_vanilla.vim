" Initial neovim configurations
" Syntax because I like colors
syntax enable
" visual size of tab
set tabstop=4
set softtabstop=4
" Tabs are spaces
set expandtab
set shiftwidth=4
set smarttab

set nowrap

" Show line numbers
" relative number is causing issues with some plugins and is generally slower
set number norelativenumber
" Highlight current line
set cursorline
" Load filetype-specific indent files
filetype plugin indent on
" Autocomplete for command menu
set wildmenu
set showcmd
" Redraw when needed
set lazyredraw

set showmatch

" Search
set incsearch
set hlsearch

set autoindent
set ruler
" Always display status line
set laststatus=2
set confirm
set visualbell
" Enable mouse control
set mouse=a
set cmdheight=2

" Enable syntax based folding
set foldmethod=syntax

" Enable code completion
"set omnifunc=syntaxcomplete#Complete

" Remove annoying 'match x of y' type message
set shortmess+=c

" Enable live substitution preview
set inccommand=nosplit

" Always show the sign column (gutter)
set signcolumn=yes

" More natural splits
set splitbelow
set splitright

" Enable autowrite
set autowrite

" Key bindings
let mapleader = ','

" exit terminal
tnoremap <leader>n <C-\><C-N>
" remove highlight
nnoremap <leader>n :nohl<CR>

" Buffers keybinds
set hidden
nnoremap <leader>T :enew<CR>
nnoremap <leader>l :bnext<CR>
nnoremap <leader>h :bprevious<CR>
nnoremap <leader>bq :bp <BAR> bd #<CR>
nnoremap <leader>bl :ls<CR>
nnoremap <leader>wq :bp <BAR> bd #<CR>:q<CR>
nnoremap <leader>ww :w<CR>

" Open init.vim file
nnoremap <leader>ei :e $MYVIMRC<CR>
" Source init.vim file
nnoremap <leader>si :source $MYVIMRC<CR>

" Syntax name of element under cursor
nnoremap zS :echo join(reverse(map(synstack(line('.'), col('.')), 'synIDattr(v:val,"name")')),' ')<cr>

" Ensures that the help is opened above
command! -nargs=1 H :above h <args><CR>

" Removes last highlight
command! Rmhl :let @/=""

" Folds keybinds
nnoremap <Space> za
