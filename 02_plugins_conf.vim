scriptencoding utf-8

" {{{ Languages

" * Pandoc
let g:pandoc#modules#disabled = ['spell']

" css,scss {{{2
augroup CSS3SCSSSyntax
    autocmd!

    autocmd FileType css,scss setlocal iskeyword+=-
augroup END
" 2}}}

" }}}

" {{{ Utility

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

" Telescope {{{2

function! RgTelescope()
    let input = input('Riprep: ')

    if input !=# ''
        "execute ':FzfRg ' . input
        execute 'lua require''telescope.builtin''.grep_string{ search = ''' . input . ''' }'
    else
        echo 'Exiting: given input was empty'
    endif
endfunction

nnoremap <leader>ff :lua require'telescope.builtin'.find_files{}<CR>
nnoremap <leader>fb :lua require'telescope.builtin'.buffers{ show_all_buffers = true }<CR>
nnoremap <leader>fg :call RgTelescope()<CR>
nnoremap <leader>gb :lua require('custom_telescope').branch({})<CR>
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
