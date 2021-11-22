local map = require('helpers.map')

require('indent_blankline').setup {
  buftype_exclude = {'terminal', 'help'},
  filetype_exclude = {'startify', 'fugitive', 'pandoc', 'packer'},
  char_list = {'|', '¦', '┆', '┊'},
  use_treesitter = false,
  show_first_indent_level = false,
  show_trailing_blankline_indent = false,
  show_current_context = true,
}

local function remap(lhss)
  for _,lhs in pairs(lhss) do
    map.nnore(lhs, lhs .. ':IndentBlanklineRefresh<CR>', { silent = true })
  end
end

remap({'zo', 'zO', 'zc', 'zC', 'za', 'zA', 'zv', 'zx', 'zX', 'zm', 'zM', 'zR', 'zr'})
