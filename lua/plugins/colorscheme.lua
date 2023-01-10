return {
  'git@github.com:Luxed/ayu-vim.git',
  branch = 'semantic-tokens-extended-colors',
  dependencies = {
    'kyazdani42/nvim-web-devicons',
  },
  config = function()
    vim.api.nvim_create_autocmd('ColorScheme', {
      callback = function()
        require('colors.post').init()
      end
    })

    vim.g.ayucolor = 'mirage'
    vim.g.ayu_italic_comment = true
    vim.g.ayu_extended_palette = true

    vim.cmd('colorscheme ayu')
  end,
  priority = 1000
}
