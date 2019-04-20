if g:dein_path == ''
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

" }}}

" {{{ Completion

" * Deoplete
" Remove preview window
set completeopt-=preview
let g:deoplete#enable_at_startup = 0
" Deoplete-rust configuration
let g:deoplete#sources#rust#racer_binary = $HOME.'/.cargo/bin/racer'
let g:deoplete#sources#rust#rust_source_path = $HOME.'/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src/'
let g:deoplete#sources#rust#documentation_max_height = 0
let g:deoplete#sources#jedi#show_docstring = 1

" * asyncomplete

au User asyncomplete_setup call asyncomplete#ale#register_source({
            \ 'name': 'rust',
            \ 'linter': 'rls',
            \})

call asyncomplete#register_source(asyncomplete#sources#ultisnips#get_source_options({
            \ 'name': 'ultisnips',
            \ 'whitelist': ['*'],
            \ 'completor': function('asyncomplete#sources#ultisnips#completor'),
            \ }))

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
            \ 'dir':  '\v[\/](\.(git|hg|svn)|\_site|node\_modules|target|packages|plugged|dein)$',
            \ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg)$',
            \}
" Use the nearest .git directory as the cwd
let g:ctrlp_working_path_mode = 'r'
" CtrlP bindings
nnoremap <leader>pp :CtrlP<CR>
nnoremap <leader>pb :CtrlPBuffer<CR>
nnoremap <leader>pm :CtrlPMixed<CR>
nnoremap <leader>ps :CtrlPMRU<CR>

" * Tagbar
" Opens tagbar to the right and moves into it
noremap <C-T> :TagbarToggle<CR>

" * Vim Markdown Preview
let vim_markdown_preview_hotkey='<C-m>'
let vim_markdown_preview_browser='Firefox Quantum'
let vim_markdown_preview_pandoc=1
let vim_markdown_preview_use_xdg_open=1
"let vim_markdown_preview_toggle=3

" }}}

" {{{ Interface

" * Airline
let g:airline_powerline_fonts = 1
" show buffers at the top of the screen
let g:airline#extensions#tabline#enabled = 1
" only show the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" * indentLine
let g:indentLine_char = '|'

" }}}
