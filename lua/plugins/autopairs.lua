local npairs = require('nvim-autopairs')

npairs.setup{
  disable_filetype = { 'TelescopePrompt' }
}

require('nvim-autopairs.completion.cmp').setup{
  map_cr = true,
  map_complete = true,
  auto_select = false,
}
