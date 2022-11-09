local navic = require('nvim-navic')
local aw = require('aw_watcher')

require('lualine').setup({
  sections = {
    lualine_x = {
      { navic.get_location, cond = navic.is_available },
      'encoding',
      'fileformat',
      'filetype',
      { aw.statusline.status, cond = aw.statusline.is_available },
    }
  },
  extensions = { 'fern', 'fugitive' }
})
