scriptencoding utf-8

" {{{ Languages

" * Pandoc
let g:pandoc#modules#disabled = ['spell']

" OmniSharp {{{

let g:OmniSharp_server_stdio = 1
let g:OmniSharp_highlight_types = 2

" }}}

" css,scss {{{2
augroup CSS3SCSSSyntax
    autocmd!

    autocmd FileType css,scss setlocal iskeyword+=-
augroup END
" 2}}}

" }}}

" {{{ Syntax/Error checkers

" Ale {{{2

let g:airline#extensions#ale#enabled=1
let g:ale_linters = {
            \ 'rust'       : [],
            \ 'glsl'       : ['glslang'],
            \ 'haskell'    : ['hie'],
            \ 'typescript' : [],
            \ 'javascript' : [],
            \ 'python'     : ['pyls'],
            \ 'html'       : [],
            \ 'vue'        : [],
            \ 'vim'        : []
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

" 2}}}

" }}}

" Coc {{{

"inoremap <silent><expr> <c-space> coc#refresh()

" Expand when pressing enter
"inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" next and last diagnostic
"nmap <silent> <leader>qd :CocList diagnostics<CR>
"nmap <silent> <leader>qn <Plug>(coc-diagnostic-next)
"nmap <silent> <leader>qp <Plug>(coc-diagnostic-prev)

" GoTo bindings
"nmap <silent> <leader>qgd <Plug>(coc-definition)
"nmap <silent> <leader>qgy <Plug>(coc-type-definition)
"nmap <silent> <leader>qgi <Plug>(coc-implementation)
"nmap <silent> <leader>qgr <Plug>(coc-references)

" show 'hover' (documentation)
"nmap <silent> <leader>qk :call CocAction('doHover')<CR>

"augroup Coc
    "autocmd CursorHold * silent call CocActionAsync('highlight')
"augroup END

"nmap <leader>qr <Plug>(coc-rename)

"nmap <leader>qa <Plug>(coc-codeaction)
"nmap <silent> <leader>qa :CocCommand actions.open<CR>
"nmap <leader>qf <Plug>(coc-fix-current)

" use `:OR` for organize import of current buffer
"command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

"let g:coc_global_extensions = ['coc-actions', 'coc-ultisnips', 'coc-rls', 'coc-json', 'coc-tsserver', 'coc-prettier', 'coc-css', 'coc-html', 'coc-emmet', 'coc-angular', 'coc-vimlsp', 'coc-vetur']

" }}}

" {{{ Utility

" {{{2 UltiSnips

"let g:UltiSnipsExpandTrigger='<c-e>'
"function FixUltiSnipsMappings()
    "inoremap <buffer> <silent> <c-j> <C-R>=UltiSnips#JumpForwards()<cr>
    "snoremap <buffer> <silent> <c-j> <Esc>:call UltiSnips#JumpForwards()<cr>
    "inoremap <buffer> <silent> <c-k> <C-R>=UltiSnips#JumpBackwards()<cr>
    "snoremap <buffer> <silent> <c-k> <Esc>:call UltiSnips#JumpBackwards()<cr>
"endfunction

" 2}}}

" {{{2 NerdTree

noremap <C-N> :NERDTreeToggle<CR>
let g:NERDTreeShowHidden=1

" 2}}}

" Switch {{{2

nnoremap <leader>ss :call switcher#Switch()<CR>
nnoremap <leader>sv :call switcher#SwitchWithOptions({'edit_command': 'vs'})<CR>
nnoremap <leader>sh :call switcher#SwitchWithOptions({'edit_command': 'sp'})<CR>

" 2}}}

" Wrap {{{2

xnoremap <leader>w :call wrap#func()<CR>

" 2}}}

" Fugitive {{{2

nnoremap <silent> <leader>gs :Gstatus<CR>
nnoremap <silent> <leader>gf :Git fetch<CR>
"nnoremap <silent> <leader>gb :Denite branches<CR>
function! s:fugitive_settings()
    nnoremap <leader>gp :Gpush<CR>
endfunction
augroup fugitiveoptions
    autocmd FileType fugitive call s:fugitive_settings()
augroup END

" 2}}}

" vim-closetag {{{2

let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.vue,*.xml'
let g:closetag_filetypes = 'html,xhtml,phtml,vue,xml'

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
            \ 't'  : '>_',
            \ 'v'  : 'VISUAL',
            \ 'V'  : 'V-LINE',
            \ '' : 'V-BLOCK',
            \ }

" 2}}}

" fzf {{{2

" fzf functions {{{3

function! CreateCenteredFloatingWindow()
    let width = min([&columns - 4, max([120, &columns - 60])])
    let height = min([&lines - 4, max([20, &lines - 10])])
    let top = ((&lines - height) / 2) - 1
    let left = (&columns - width) / 2
    let opts = {
                \'relative': 'editor',
                \'row': top,
                \'col': left,
                \'width': width,
                \'height': height,
                \'style': 'minimal'
                \}

    let top = "╭" . repeat("─", width - 2) . "╮"
    let mid = "│" . repeat(" ", width - 2) . "│"
    let bot = "╰" . repeat("─", width - 2) . "╯"
    let lines = [top] + repeat([mid], height - 2) + [bot]
    let s:buf = nvim_create_buf(v:false, v:true)
    call nvim_buf_set_lines(s:buf, 0, -1, v:true, lines)
    call nvim_open_win(s:buf, v:true, opts)
    set winhl=Normal:Floating
    let opts.row += 1
    let opts.height -= 2
    let opts.col += 2
    let opts.width -= 4
    call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
    au BufWipeout <buffer> exe 'bw '.s:buf
endfunction

function! RgFZF()
    let input = input('Riprep: ')

    if input !=# ''
        "execute ':FzfRg ' . input
        execute 'lua require''telescope.builtin''.grep_string{ search = ''' . input . ''' }'
    else
        echo 'Exiting: given input was empty'
    endif
endfunction

function! GitTagsFZF()
    let l:tags = systemlist('git ls-remote -t --refs')
    let l:first_tag = remove(l:tags, 0) " The first line is always the information about the remote

    if !empty(l:tags)
        function! TransformTag(key, val)
            return substitute(a:val, '^.*refs\/tags\/', '', '')
        endfunction
        let l:tags = map(l:tags, function('TransformTag'))
    endif

    return l:tags
endfunction

function! GitBranchesFZF()
    return systemlist('git branch -r --sort=-committerdate --format="%(refname:lstrip=3)"')
endfunction

" 3}}}

let g:fzf_layout =  { 'window': 'call CreateCenteredFloatingWindow()' }
let g:fzf_command_prefix = 'Fzf'
let g:fzf_preview_window = ''

nnoremap <silent> <leader>fd :call fzf#run(fzf#wrap({'source': 'rg --files'}))<CR>
nnoremap <leader>ff :lua require'telescope.builtin'.find_files{}<CR>
"nnoremap <leader>fb :FzfBuffers<CR>
nnoremap <leader>fb :lua require'telescope.builtin'.buffers{ show_all_buffers = true }<CR>
" 'outline': tags for current buffer only
nnoremap <leader>fo :FzfBTags<CR>
nnoremap <leader>fg :call RgFZF()<CR>
"nnoremap <silent> <leader>gb :call fzf#run(fzf#wrap({'source': GitBranchesFZF(), 'sink': 'Git checkout'}))<CR>
nnoremap <leader>gb :lua require('custom_telescope').branch({})<CR>
"nnoremap <silent> <leader>gt :call fzf#run(fzf#wrap({'source': GitTagsFZF(), 'sink': 'Git checkout'}))<CR>
nnoremap <leader>gt :lua require('custom_telescope').tags({})<CR>

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

packadd vim-startify
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

let g:pencil_higher_contrast_ui = 1
let g:pencil_gutter_color = 0

" }}}
