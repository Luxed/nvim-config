vim.cmd('packadd nvim-autopairs')
local npairs = require('nvim-autopairs')

npairs.setup{
  disable_filetype = { 'TelescopPrompt' }
}

require('nvim-autopairs.completion.compe').setup{
  map_cr = true,
  map_complete = true,
}
