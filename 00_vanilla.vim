" Initial neovim configurations

" {{{ Setting options

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
set nohlsearch

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
augroup omnicomp
    au FileType css set omnifunc=csscomplete#CompleteCSS
    au FileType html set omnifunc=htmlcomplete#CompleteTags
augroup END

" Remove annoying 'match x of y' type message
set shortmess+=c

if g:minimal_config != 1
    " Enable live substitution preview
    set inccommand=nosplit

    " Show the sign column (gutter)
    set signcolumn=yes
endif

" More natural splits
set splitbelow
set splitright

" Enable autowrite
set autowrite

set updatetime=300

set diffopt+=internal,algorithm:patience

" }}}

" {{{ Keybindings

" Key bindings
let mapleader = ','

nnoremap ; :

" exit terminal
tnoremap <leader>n <C-\><C-N>

" Buffers keybinds
set hidden
nnoremap <leader>T :enew<CR>
nnoremap <leader>l :bnext<CR>
nnoremap <leader>h :bprevious<CR>
nnoremap <leader>bq :b# <BAR> bd #<CR>
nnoremap <leader>bl :ls<CR>
nnoremap <leader># :b#<CR>

" Open init.vim file
nnoremap <leader>ei :e $MYVIMRC<CR>
" Source init.vim file
nnoremap <leader>si :source $MYVIMRC<CR>

" Syntax name of element under cursor
nnoremap zS :echo join(reverse(map(synstack(line('.'), col('.')), 'synIDattr(v:val,"name")')),' ')<cr>

" Removes last highlight
command! Rmhl :let @/=""

" remove highlight
nnoremap <leader>th :set hlsearch!<CR>
nnoremap <leader>n :nohl<CR>
nnoremap <leader>N :Rmhl<CR>

" Folds keybinds
nnoremap <Space> za
nnoremap <S-Space> zA

" Open loclist
nnoremap <silent> <leader>ol :lopen<CR>
" Open quickfix
nnoremap <silent> <leader>oc :copen<CR>

" }}}

" {{{ Session management

" Save the session only if it exists
function! s:SaveSession()
    if filereadable(getcwd() . '/Session.vim')
        mksession!
    endif
endfunction

"augroup session
    "autocmd VimLeave * call s:SaveSession()
"augroup END

function! s:DeleteHiddenBuffers() " Vim with the 'hidden' option
    let tpbl=[]
    call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
    for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
        silent execute 'bwipeout' buf
    endfor
endfunction
command! DeleteHiddenBuffers call s:DeleteHiddenBuffers()

" }}}
