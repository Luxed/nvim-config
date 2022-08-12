-- setup an autocommand to modify themes to my liking
vim.api.nvim_create_autocmd('ColorScheme', {
  callback = function()
    require('colors.post').init()
  end
})
-- Ayu
vim.g.ayucolor = 'mirage'
vim.g.ayu_italic_comment = true
vim.g.ayu_extended_palette = true
-- load colorscheme as soon as possible
vim.cmd('colorscheme ayu')
