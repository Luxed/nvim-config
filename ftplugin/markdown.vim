" From https://github.com/plasticboy/vim-markdown
function! s:TableFormat()
    let l:pos = getpos('.')
    normal! {
    " Search instead of `normal! j` because of the table at beginning of file edge case.
    call search('|')
    normal! j
    " Remove everything that is not a pipe, colon or hyphen next to a colon othewise
    " well formated tables would grow because of addition of 2 spaces on the separator
    " line by Tabularize /|.
    let l:flags = (&gdefault ? '' : 'g')
    execute 's/\(:\@<!-:\@!\|[^|:-]\)//e' . l:flags
    execute 's/--/-/e' . l:flags
    Tabularize /|
    " Move colons for alignment to left or right side of the cell.
    execute 's/:\( \+\)|/\1:|/e' . l:flags
    execute 's/|\( \+\):/|:\1/e' . l:flags
    execute 's/ /-/' . l:flags
    call setpos('.', l:pos)
endfunction

function! s:InsertItalic()
    normal! a__
endfunction

function! s:InsertBold()
    normal! a****
    normal! h
endfunction

command! -buffer TableFormat call s:TableFormat()

" table format
nnoremap <buffer> <leader>tf <cmd>TableFormat<cr>
" table emtpy cell
nnoremap <buffer> <leader>tec <cmd>normal vi\|r <cr>

inoremap <buffer> <C-i> <cmd>call <SID>InsertItalic()<cr>
inoremap <buffer> <C-b> <cmd> call <SID>InsertBold()<cr>

" Enable concealing for markdown files
setlocal conceallevel=1

setlocal foldmethod=expr
setlocal foldexpr=nvim_treesitter#foldexpr()
