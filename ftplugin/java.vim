lua require('jdtls').start_or_attach({cmd = { 'jdtls' }})

nnoremap <buffer><silent> <leader>qa <cmd>lua require('jdtls').code_action()<CR>

command! -buffer OR :lua require('jdtls').organize_imports()<CR>
command! -buffer RF :lua require('jdtls').code_action(false, 'refactor')<CR>
