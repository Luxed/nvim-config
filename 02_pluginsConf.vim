" ===       Languages       ===

" * Pandoc
let g:pandoc#modules#disabled = ['spell']

" * Python Syntax
let g:python_highlight_all = 1

" * Neovim Typescript
autocmd FileType typescript nnoremap K :TSDoc<CR>

" === Syntax/Error checkers ===

" * Ale
let g:airline#extensions#ale#enabled=1
let g:ale_linters = {
    \ 'rust'       : ['rls'],
    \ 'glsl'       : ['glslang'],
    \ 'haskell'    : ['hie'],
    \ 'typescript' : ['tsserver', 'tslint']
\}
let g:ale_rust_rls_toolchain = 'stable'
let g:ale_completion_enabled = 0
let g:ale_open_list = 1
"let g:ale_set_loclist = 0
"let g:ale_set_quickfix = 1
"let g:ale_lint_delay=50
" ALE bindings
nnoremap <leader>an :ALENextWrap<CR>
nnoremap <leader>ap :ALEPreviousWrap<CR>
nnoremap <leader>ah :ALEHover<CR>
nnoremap <leader>ag :ALEGoToDefinition<CR>
nnoremap <leader>ar :ALEFindReferences<CR>

" ===      Completion       ===

" * Deoplete
" Remove preview window
set completeopt-=preview
let g:deoplete#enable_at_startup = 1
" Deoplete-rust configuration
let g:deoplete#sources#rust#racer_binary = $HOME.'/.cargo/bin/racer'
let g:deoplete#sources#rust#rust_source_path = $HOME.'/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src/'
let g:deoplete#sources#rust#documentation_max_height = 0
let g:deoplete#sources#jedi#show_docstring = 1

" ===        Utility        ===

" * UltiSnips
let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<tab>'
let g:UltiSnipsJumpBackwardTrigger='<s-tab>'

" * NerdTree
noremap <C-N> :NERDTreeToggle<CR>
let g:NERDTreeShowHidden=1

" * CtrlP
" Setup some default ignores
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn)|\_site)$',
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
"noremap <C-T> :TagbarToggle<CR><C-W><C-L>

" * Vim Markdown Preview
let vim_markdown_preview_hotkey='<C-m>'
let vim_markdown_preview_browser='Firefox Quantum'
let vim_markdown_preview_pandoc=1
let vim_markdown_preview_use_xdg_open=1
"let vim_markdown_preview_toggle=3

" ===       Interface       ===

" * Airline
let g:airline_powerline_fonts = 1
" show buffers at the top of the screen
let g:airline#extensions#tabline#enabled = 1
" only show the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" ===        Themes         ===
