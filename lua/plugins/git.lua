return {
  {
    'tpope/vim-fugitive',
    lazy = true,
    cmd = { 'Git' },
    keys = {
      { '<leader>gs', ':Git<CR>' },
      { '<leader>gf', ':Git fetch<CR>' },
    },
  },
  {
    'junegunn/gv.vim',
    dependencies = {
      'tpope/vim-fugitive',
    },
    cmd = 'GV'
  },
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  },
}
