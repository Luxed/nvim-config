setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4

nnoremap <buffer> <silent> K :call CocAction('doHover')<CR>
nmap <buffer> <silent> gd <Plug>(coc-definition)
