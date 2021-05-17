vim.cmd('packadd indent-blankline.nvim')

vim.g.indent_blankline_show_first_indent_level = false
vim.g.indent_blankline_show_trailing_blankline_indent = false
vim.g.indent_blankline_filetype_exclude = { 'help' }

-- TreeSitter related settings
vim.g.indent_blankline_use_treesitter = false
vim.g.indent_blankline_show_current_context = true
