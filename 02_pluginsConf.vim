scriptencoding utf-8

if g:dein_path ==# ''
    echoerr 'Couldn''t find dein path, plugins config won''t be loaded'
    finish
endif

" {{{ Languages

" * Pandoc
let g:pandoc#modules#disabled = ['spell']

" }}}

" {{{ Syntax/Error checkers

" Ale {{{2

let g:airline#extensions#ale#enabled=1
let g:ale_linters = {
            \ 'rust'       : [],
            \ 'glsl'       : ['glslang'],
            \ 'haskell'    : ['hie'],
            \ 'typescript' : ['tsserver', 'tslint'],
            \ 'javascript' : ['tsserver'],
            \ 'python'     : ['pyls'],
            \ 'html'       : []
            \}

let g:ale_rust_rls_toolchain = 'stable'
let g:ale_completion_enabled = 0
let g:ale_open_list = 0
let g:ale_list_window_size = 6
"let g:ale_set_loclist = 0
"let g:ale_set_quickfix = 1
let g:ale_lint_delay=50
let g:ale_echo_cursor=1
let g:ale_virtualtext_cursor=0
let g:ale_cursor_detail=0

" ALE bindings
nnoremap <leader>an :ALENextWrap<CR>
nnoremap <leader>ap :ALEPreviousWrap<CR>
nnoremap <leader>ah :ALEHover<CR>
nnoremap <leader>ag :ALEGoToDefinition<CR>
nnoremap <leader>ar :ALEFindReferences<CR>
nnoremap <leader>ak :ALEDocumentation<CR>

"autocmd FileType typescript,rust set omnifunc=ale#completion#OmniFunc

" 2}}}

" }}}

" {{{ Completion

" Deoplete {{{2

" Remove preview window
set completeopt-=preview
let g:deoplete#enable_at_startup = 0
" Deoplete-rust configuration
"let g:deoplete#sources#rust#racer_binary = $HOME.'/.cargo/bin/racer'
"let g:deoplete#sources#rust#rust_source_path = $HOME.'/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src/'
"let g:deoplete#sources#rust#documentation_max_height = 0
"let g:deoplete#sources#jedi#show_docstring = 1

" 2}}}

" Ncm2 {{{2

"set completeopt=noinsert,menuone,noselect
"autocmd BufEnter * call ncm2#enable_for_buffer()

function! s:setup_ncm2_sources()

    call ncm2#register_source({
                \ 'name' : 'rust',
                \ 'priority': 9,
                \ 'subscope_enable': 1,
                \ 'scope': ['rust'],
                \ 'mark': 'rust',
                \ 'word_pattern': '[\w]+',
                \ 'complete_pattern': '\(::|\.|^use\s\)*',
                \ 'on_complete': ['ncm2#on_complete#omni', 'ale#completion#OmniFunc'],
                \ })

    call ncm2#register_source({
                \ 'name': 'typescript',
                \ 'priority': 9,
                \ 'subscope_enable': 1,
                \ 'scope': ['typescript'],
                \ 'mark': 'typescript',
                \ 'word_pattern': '[\w]+',
                \ 'complete_pattern': '\.*',
                \ 'on_complete': ['ncm2#on_complete#omni', 'ale#completion#OmniFunc'],
                \ })

    call ncm2#register_source({'name' : 'css',
                \ 'priority': 9,
                \ 'subscope_enable': 1,
                \ 'scope': ['css', 'scss', 'less'],
                \ 'mark': 'css',
                \ 'word_pattern': '[\w\-]+',
                \ 'complete_pattern': ':\s*',
                \ 'on_complete': ['ncm2#on_complete#omni', 'csscomplete#CompleteCSS'],
                \ })

endfunction

augroup ncmcomp
    au User Ncm2Plugin call s:setup_ncm2_sources()
augroup END

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

augroup ayncompletecomp
    au User asyncomplete_setup call s:setup_asyncomplete_sources()
augroup END

" 2}}}

" coc {{{2

inoremap <silent><expr> <c-space> coc#refresh()

" Expand when pressing enter
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" next and last diagnostic
nmap <silent> <leader>qn <Plug>(coc-diagnostic-next)
nmap <silent> <leader>qp <Plug>(coc-diagnostic-prev)

" GoTo bindings
nmap <silent> <leader>qgd <Plug>(coc-definition)
nmap <silent> <leader>qgy <Plug>(coc-type-definition)
nmap <silent> <leader>qgi <Plug>(coc-implementation)
nmap <silent> <leader>qgr <Plug>(coc-references)

" show 'hover' (documentation)
nmap <silent> <leader>qk :call CocAction('doHover')<CR>

augroup Coc
    autocmd CursorHold * silent call CocActionAsync('highlight')
augroup END

nmap <leader>qr <Plug>(coc-rename)

nmap <leader>qa <Plug>(coc-codeaction)
nmap <leader>qf <Plug>(coc-fix-current)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

function! InstallCocExtensions()
    CocInstall coc-ultisnips
    CocInstall coc-rls
    CocInstall coc-json
    CocInstall coc-tsserver
    CocInstall coc-css
    CocInstall coc-html
    CocInstall coc-emmet
    CocInstall coc-angular
endfunction

" 2}}}

" }}}

" {{{ Utility

" * UltiSnips
let g:UltiSnipsExpandTrigger='<c-e>'

" * NerdTree
noremap <C-N> :NERDTreeToggle<CR>
let g:NERDTreeShowHidden=1

" * Tagbar
" Opens tagbar to the right and moves into it
noremap <C-T> :TagbarToggle<CR>

" * Switch
nnoremap <leader>ss :Switch 

" * DelimitMate
augroup delimitmateoptions
    au FileType html let b:delimitMate_matchpairs = "(:),[:],{:}"
augroup END
let delimitMate_expand_space = 1
let delimitMate_expand_cr = 1

" Fugitive {{{2

nnoremap <silent> <leader>gs :Gstatus<CR>
nnoremap <silent> <leader>gf :Git fetch<CR>
nnoremap <silent> <leader>gb :Denite branches<CR>
function! s:fugitive_settings()
    nnoremap <leader>gp :Gpush<CR>
endfunction
augroup fugitiveoptions
    autocmd FileType fugitive call s:fugitive_settings()
augroup END

" 2}}}

" }}}

" {{{ Interface

" Airline {{{2

let g:airline_powerline_fonts = 1
" show buffers at the top of the screen
let g:airline#extensions#tabline#enabled = 1
" only show the filename
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#show_tab_nr = 1

" I got tired of the 'INSERT COMPL' jumping all of the time in Airline
let g:airline_mode_map = {
            \ '__' : '------',
            \ 'c'  : 'COMMAND',
            \ 'i'  : 'INSERT',
            \ 'ic' : 'INSERT',
            \ 'ix' : 'INSERT',
            \ 'n'  : 'NORMAL',
            \ 'ni' : '(INSERT)',
            \ 'no' : 'OP PENDING',
            \ 'R'  : 'REPLACE',
            \ 'Rv' : 'V REPLACE',
            \ 's'  : 'SELECT',
            \ 'S'  : 'S-LINE',
            \ '' : 'S-BLOCK',
            \ 't'  : '',
            \ 'v'  : 'VISUAL',
            \ 'V'  : 'V-LINE',
            \ '' : 'V-BLOCK',
            \ }

" 2}}}

" Denite {{{2

" Custom options
call denite#custom#option('default', {
            \ 'start_filter'      : 1,
            \ 'filter_updatetime' : 100,
            \ 'prompt'            : '',
            \ 'split'             : 'floating'
            \ })

" Ripgrep for file/rec and grep sources
call denite#custom#var('file/rec', 'command', ['rg', '--files', '--glob', '!.git'])
call denite#custom#var('grep', 'command', ['rg'])
call denite#custom#var('grep', 'recursive_opts', [])

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
function! s:denite_my_settings() abort
    nnoremap <silent><buffer><expr> <Esc>
                \ denite#do_map('quit')
    nnoremap <silent><buffer><expr> <CR>
                \ denite#do_map('do_action')
    nnoremap <silent><buffer><expr> d
                \ denite#do_map('do_action', 'delete')
    nnoremap <silent><buffer><expr> p
                \ denite#do_map('do_action', 'preview')
    nnoremap <silent><buffer><expr> i
                \ denite#do_map('open_filter_buffer')
    nnoremap <silent><buffer><expr> <Space>
                \ denite#do_map('toggle_select').'j'
endfunction

function! s:denite_filter_my_settings() abort
    inoremap <silent><buffer><expr> <C-c>
                \ denite#do_map('quit')
    nnoremap <silent><buffer><expr> <Esc>
                \ denite#do_map('quit')
    inoremap <silent><buffer><expr> <C-e>
                \ denite#do_map('do_action')
    inoremap <silent><buffer> <C-j> <Esc><C-w>p:call cursor(line('.')+1,0)<CR><C-w>pA
    inoremap <silent><buffer> <C-k> <Esc><C-w>p:call cursor(line('.')-1,0)<CR><C-w>pA
endfunction

augroup deniteoptions
    autocmd FileType denite call s:denite_my_settings()
    autocmd FileType denite-filter call s:denite_filter_my_settings()
augroup END

" 2}}}

" Startify {{{2

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

" Semshi {{{2

let g:semshi#error_sign = v:false
let g:semshi#always_update_all_highlights = v:false

" 2}}}

" }}}
