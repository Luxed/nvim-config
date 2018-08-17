" Custom commands
command! -buffer Run :below 10sp term://python %:p

" Bindings
noremap <buffer> <F5> :Run<CR>
