local navic = require('nvim-navic')

local aw_section = {
  function()
    return require('aw_watcher').is_connected() and '祥' or '精'
  end,
  cond = function()
    local has_aw, _ = pcall(require, 'aw_watcher')
    return has_aw
  end
}

local winbar = {
  lualine_c = {
    {
      function()
        return vim.fn.expand('%:t')
      end,
      cond = navic.is_available
    },
    {
      function()
        return navic.get_location({
          highlight = true,
        })
      end,
      cond = navic.is_available
    },
  }
}

require('lualine').setup({
  sections = {
    lualine_x = {
      'encoding',
      'fileformat',
      'filetype',
      aw_section,
    }
  },
  winbar = winbar,
  inactive_winbar = winbar,
  extensions = { 'fugitive', 'neo-tree' },
  options = {
    theme = require('ayu').lualine_colors(),
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
  }
})
