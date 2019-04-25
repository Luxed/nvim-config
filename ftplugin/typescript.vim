" Custom commands
command! -buffer Build :below 10sp term://tsc %:p

" Bindings
noremap <buffer> <F4> :Build<CR>

