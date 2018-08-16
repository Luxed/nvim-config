" Custom commands
command! Build :below 10sp term://tsc %:p

" Bindings
noremap <F4> :Build<CR>
