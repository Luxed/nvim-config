require('indent_blankline').setup {
  buftype_exclude = {'terminal', 'help'},
  filetype_exclude = {'startify', 'fugitive', 'pandoc', 'packer', 'lsp-installer', 'mason.nvim'},
  char_list = {'|', '¦', '┆', '┊'},
  use_treesitter = false,
  show_first_indent_level = false,
  show_trailing_blankline_indent = false,
  show_current_context = true,
}

require('keymaps').indent_blankline()
