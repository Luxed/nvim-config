nnoremap <buffer><silent> <leader>qa <cmd>lua require('jdtls').code_action()<CR>
nmap <buffer><silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <buffer><silent> K <cmd>lua vim.lsp.buf.hover()<CR>

command! -buffer OR :lua require('jdtls').organize_imports()<CR>
command! -buffer RF :lua require('jdtls').code_action(false, 'refactor')<CR>
