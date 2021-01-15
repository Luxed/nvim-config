setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4

nnoremap <buffer><silent> K <cmd>lua vim.lsp.buf.hover()<CR>
nmap <buffer><silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
