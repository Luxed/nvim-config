setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4

" Custom commands
command! -buffer Build :below 10sp term://tsc %:p

" Bindings
noremap <buffer> <F4> :Build<CR>

nnoremap <buffer> <silent> K :call CocAction('doHover')<CR>
