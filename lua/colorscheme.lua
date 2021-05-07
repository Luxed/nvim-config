-- setup an autocommand to modify themes to my liking
vim.cmd('au! ColorScheme * lua require("colors.post").init()')
-- Ayu
vim.g.ayucolor = 'mirage'
vim.g.ayu_italic_comment = true
vim.g.ayu_experimental_colors = true
-- load colorscheme as soon as possible
vim.cmd('colorscheme ayu')
