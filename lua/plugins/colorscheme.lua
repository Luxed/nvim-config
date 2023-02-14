return {
  {
    'ayu-vim',
    url = 'git@github.com:Luxed/ayu-vim.git',
    branch = 'semantic-tokens-extended-colors',
    priority = 1000,
    config = function()
      vim.g.ayucolor = 'mirage'
      vim.g.ayu_italic_comment = true
      vim.g.ayu_extended_palette = true

      vim.cmd('colorscheme ayu')
    end,
  },
  {
    'kyazdani42/nvim-web-devicons',
    config = function()
      vim.api.nvim_create_autocmd('ColorScheme', {
        callback = function()
          require('colors.post').init()
        end
      })
    end,
    priority = 1001
  }
}
