local navic = require('nvim-navic')

local function aw_status()
  --[[ local has_aw, aw = pcall(require, 'aw_watcher')
  return .statusline.status() or '' ]]
  return require('aw_watcher').statusline.status()
end

local function aw_cond()
  local has_aw, _ = pcall(require, 'aw_watcher')
  return has_aw
end

require('lualine').setup({
  sections = {
    lualine_x = {
      { navic.get_location, cond = navic.is_available },
      'encoding',
      'fileformat',
      'filetype',
      { aw_status, cond = aw_cond },
    }
  },
  extensions = { 'fern', 'fugitive' }
})
