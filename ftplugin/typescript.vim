setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
let &l:breakat = ' (=*-+;,/'

nnoremap <buffer><silent> K <cmd>lua vim.lsp.buf.hover()<CR>
nmap <buffer><silent> gd <cmd>lua vim.lsp.buf.definition()<CR>

"au BufWritePost *.ts TSBufDisable highlight | TSBufEnable hightlight
autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
autocmd CursorHold <buffer> lua vim.lsp.util.show_line_diagnostics()
