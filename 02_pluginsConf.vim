" Stop trying to configure plugins if dein_path doesn't exist
if g:dein_path == ''
    echoerr 'Couldn''t find dein path, plugins config won''t be loaded'
    finish
endif

" {{{ Languages

" * Pandoc
let g:pandoc#modules#disabled = ['spell']

" * Python Syntax
let g:python_highlight_all = 1

" }}}

" {{{ Syntax/Error checkers

" * Ale
let g:airline#extensions#ale#enabled=1
let g:ale_linters = {
            \ 'rust'       : ['rls'],
            \ 'glsl'       : ['glslang'],
            \ 'haskell'    : ['hie'],
            \ 'typescript' : ['tsserver', 'tslint'],
            \ 'python'     : ['flake8'],
            \ 'html'       : []
            \}

let g:ale_rust_rls_toolchain = 'stable'
let g:ale_completion_enabled = 0
let g:ale_open_list = 0
let g:ale_list_window_size = 6
"let g:ale_set_loclist = 0
"let g:ale_set_quickfix = 1
let g:ale_lint_delay=50
" ALE bindings
nnoremap <leader>an :ALENextWrap<CR>
nnoremap <leader>ap :ALEPreviousWrap<CR>
nnoremap <leader>ah :ALEHover<CR>
nnoremap <leader>ag :ALEGoToDefinition<CR>
nnoremap <leader>ar :ALEFindReferences<CR>
nnoremap <leader>ak :ALEDocumentation<CR>

"autocmd FileType typescript,rust set omnifunc=ale#completion#OmniFunc

" }}}

" {{{ Completion

"" * Deoplete
"" Remove preview window
"set completeopt-=preview
"let g:deoplete#enable_at_startup = 0
"" Deoplete-rust configuration
"let g:deoplete#sources#rust#racer_binary = $HOME.'/.cargo/bin/racer'
"let g:deoplete#sources#rust#rust_source_path = $HOME.'/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src/'
"let g:deoplete#sources#rust#documentation_max_height = 0
"let g:deoplete#sources#jedi#show_docstring = 1

" Ncm2 {{{2

set completeopt=noinsert,menuone,noselect
autocmd BufEnter * call ncm2#enable_for_buffer()

au User Ncm2Plugin call ncm2#register_source({
            \ 'name' : 'rust',
            \ 'priority': 9,
            \ 'subscope_enable': 1,
            \ 'scope': ['rust'],
            \ 'mark': 'rust',
            \ 'word_pattern': '[\w]+',
            \ 'complete_pattern': '::|\.',
            \ 'on_complete': ['ncm2#on_complete#omni', 'ale#completion#OmniFunc'],
            \ })

" 2}}}

" Asyncomplete sources {{{2

function! s:setup_asyncomplete_sources()
    " Buffer asyncomplete source
    call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
                \ 'name': 'buffer',
                \ 'whitelist': ['*'],
                \ 'completor': function('asyncomplete#sources#buffer#completor'),
                \ }))

    " Files asyncomplete source
    call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
                \ 'name': 'file',
                \ 'whitelist': ['*'],
                \ 'priority': 10,
                \ 'completor': function('asyncomplete#sources#file#completor')
                \ }))

    " Ultisnips asyncomplete source
    call asyncomplete#register_source(asyncomplete#sources#ultisnips#get_source_options({
                \ 'name': 'ultisnips',
                \ 'whitelist': ['*'],
                \ 'completor': function('asyncomplete#sources#ultisnips#completor'),
                \ }))

    " ALE asyncomplete source
    call asyncomplete#ale#register_source({
                \ 'name': 'typescript',
                \ 'linter': 'tsserver'
                \ })

    call asyncomplete#ale#register_source({
                \ 'name': 'rust',
                \ 'linter': 'rls'
                \ })

    " VIM asyncomplete source
    call asyncomplete#register_source(asyncomplete#sources#necovim#get_source_options({
                \ 'name': 'necovim',
                \ 'whitelist': ['vim'],
                \ 'completor': function('asyncomplete#sources#necovim#completor'),
                \ }))
endfunction

au User asyncomplete_setup call s:setup_asyncomplete_sources()

" 2}}}

" }}}

" {{{ Utility

" * UltiSnips
let g:UltiSnipsExpandTrigger='<c-e>'

" * NerdTree
noremap <C-N> :NERDTreeToggle<CR>
let g:NERDTreeShowHidden=1

" * CtrlP
" Setup some default ignores
let g:ctrlp_custom_ignore = {
            \ 'dir':  '\v[\/](\.(git|hg|svn)|_site|node_modules|target|packages|plugged|dein)$',
            \ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg)$',
            \}
" Use the nearest .git directory as the cwd
let g:ctrlp_working_path_mode = 'r'
" CtrlP bindings
nnoremap <leader>pp :CtrlP<CR>
nnoremap <leader>pb :CtrlPBuffer<CR>
nnoremap <leader>pm :CtrlPMixed<CR>
nnoremap <leader>ps :CtrlPMRU<CR>
nnoremap <leader>pt :CtrlPTag<CR>

if executable('rg')
    set grepprg=rg\ --color=never
    let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
    let g:ctrlp_use_caching = 0
endif

" * Tagbar
" Opens tagbar to the right and moves into it
noremap <C-T> :TagbarToggle<CR>

" * Vim Markdown Preview
let vim_markdown_preview_hotkey='<C-m>'
let vim_markdown_preview_browser='Firefox Quantum'
let vim_markdown_preview_pandoc=1
let vim_markdown_preview_use_xdg_open=1
"let vim_markdown_preview_toggle=3

" * Switch
nnoremap <leader>ss :Switch 

" }}}

" {{{ Interface

" * Airline
let g:airline_powerline_fonts = 0
" show buffers at the top of the screen
let g:airline#extensions#tabline#enabled = 1
" only show the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" I got tired of the 'INSERT COMPL' jumping all of the time in Airline
let g:airline_mode_map = {
            \ 'ic': 'INSERT',
            \ 'ix': 'INSERT'
            \}

" * indentLine
let g:indentLine_char = '|'

" Denite {{{2

" Custom options
call denite#custom#option('default', {'start_filter': 1})

" Ripgrep for file/rec and grep sources
call denite#custom#var('file/rec', 'command', ['rg', '--files', '--glob', '!.git'])
call denite#custom#var('grep', 'command', ["rg"])
call denite#custom#var('grep', 'recursive_opts', [])

" Custom mappings
call denite#custom#map('insert', '<C-j>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('insert', '<C-k>', '<denite:move_to_previous_line>', 'noremap')

" Devicons for new file sources
call denite#custom#source('file,file/rec,file/mru,file/old,file/point', 'converters', ['devicons_denite_converter'])

nnoremap <leader>df :Denite file/rec<CR>
nnoremap <leader>dt :Denite tag<CR>
nnoremap <leader>db :Denite buffer<CR>
nnoremap <leader>do :Denite outline<CR>
nnoremap <leader>dg :Denite grep<CR>

" * Fruzzy
let g:fruzzy#usenative = 1 " Native implementation, do `call fruzzy#install()`
let g:fruzzy#sortonempty = 1 " Sort with buffer name when search is empty

call denite#custom#source('_', 'matchers', ['matcher/fruzzy'])

" Define mappings
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
    nnoremap <silent><buffer><expr> <CR>
                \ denite#do_map('do_action')
    nnoremap <silent><buffer><expr> d
                \ denite#do_map('do_action', 'delete')
    nnoremap <silent><buffer><expr> p
                \ denite#do_map('do_action', 'preview')
    nnoremap <silent><buffer><expr> q
                \ denite#do_map('quit')
    nnoremap <silent><buffer><expr> i
                \ denite#do_map('open_filter_buffer')
    nnoremap <silent><buffer><expr> <Space>
                \ denite#do_map('toggle_select').'j'
endfunction

autocmd FileType denite-filter call s:denite_filter_my_settings()
function! s:denite_filter_my_settings() abort
    inoremap <silent><buffer><expr> <C-e>
                \ denite#do_map('do_action')
    inoremap <silent><buffer><expr> <C-c>
                \ denite#do_map('quit')
    inoremap <silent><buffer> <C-j> <Esc><C-w>p:call cursor(line('.')+1,0)<CR><C-w>pA
    inoremap <silent><buffer> <C-k> <Esc><C-w>p:call cursor(line('.')-1,0)<CR><C-w>pA
endfunction

" 2}}}

" startify {{{2

let g:startify_change_to_dir = 0
"let g:startify_change_to_vcs_root = 1

let g:ascii = [
            \ '  _   _                 _           ',
            \ ' | \ | |               (_)          ',
            \ ' |  \| | ___  _____   ___ _ __ ___  ',
            \ ' | . ` |/ _ \/ _ \ \ / / | ''_ ` _ \ ',
            \ ' | |\  |  __/ (_) \ V /| | | | | | |',
            \ ' |_| \_|\___|\___/ \_/ |_|_| |_| |_|',
            \ '                                    '
            \ ]

let g:startify_custom_header = g:ascii + startify#fortune#boxed()

let g:startify_lists = [
            \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
            \ { 'type': 'files',     'header': ['   MRU']            },
            \ { 'type': 'sessions',  'header': ['   Sessions']       },
            \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
            \ { 'type': 'commands',  'header': ['   Commands']       },
            \ ]

" 2}}}

" }}}
