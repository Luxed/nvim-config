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

" Show line numbers
set number
" Highlight current line
set cursorline
" Load filetype-specific indent files
filetype plugin indent on
" Autocomplete for command menu
set wildmenu
set showcmd
"redraw when needed
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

" Enable live substitution preview
set inccommand=nosplit

" Always show the sign column (gutter)
set signcolumn=yes

" Key bindings
let mapleader = ","

" exit terminal
tnoremap <leader>n <C-\><C-N>
" remove highlight
nmap <leader>n :nohl<CR>

" Buffers keybinds
set hidden
nmap <leader>T :enew<CR>
nmap <leader>l :bnext<CR>
nmap <leader>h :bprevious<CR>
nmap <leader>bq :bp <BAR> bd #<CR>
nmap <leader>bl :ls<CR>

" Syntax name of element under cursor
nnoremap zS :echo join(reverse(map(synstack(line('.'), col('.')), 'synIDattr(v:val,"name")')),' ')<cr>

" Enable autowrite
set autowrite

" Folds keybinds
nmap <Space> za
nmap <leader><Space> zc
" Navigation between folds
nnoremap <silent> <leader>zj :call NextClosedFold('j')<CR>
nnoremap <silent> <leader>zk :call NextClosedFold('k')<CR>
function! NextClosedFold(dir)
    let cmd = 'norm!z' . a:dir
    let view = winsaveview()
    let [l0, l, open] = [0, view.lnum, 1]
    while l != l0 && open
        exe cmd
        let [l0, l] = [l, line('.')]
        let open = foldclosed(l) < 0
    endwhile
    if open
        call winrestview(view)
    endif
endfunction
