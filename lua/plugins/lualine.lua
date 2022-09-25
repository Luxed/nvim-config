local navic = require('nvim-navic')

require('lualine').setup({
  sections = {
    lualine_x = {
      { navic.get_location, cond = navic.is_available },
      'encoding',
      'fileformat',
      'filetype'
    }
  },
  extensions = { 'fern', 'fugitive' }
})
