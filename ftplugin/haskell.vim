command! -buffer Run :below 10sp term://runhaskell %:p

noremap <buffer> <F5> :Run<CR>
