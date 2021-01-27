vim.cmd('packadd nvim-compe')

require('compe').setup {
  enabled = true,
  source = {
    path = true,
    buffer = true,
    nvim_lsp = true
  }
}

map.inore('<C-Space>', 'compe#complete()', { expr = true, silent = true })
map.inore('<CR>', 'compe#confirm("<CR>")', { expr = true, silent = true })
