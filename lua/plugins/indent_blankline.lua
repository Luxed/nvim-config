vim.cmd('packadd indent-blankline.nvim')

require('indent_blankline').setup {
  buftype_exclude = {"terminal", "help"},
  char_list = {'|', '¦', '┆', '┊'},
  use_treesitter = false,
  show_first_indent_level = false,
  show_trailing_blankline_indent = false,
  show_current_context = true,
}
