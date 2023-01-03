return {
  'nvim-neo-tree/neo-tree.nvim',
  dependencies = {
    'MunifTanjim/nui.nvim'
  },
  config = function()
    require('neo-tree').setup({
      filesystem = {
        hijack_netrw_behavior = 'open_current'
      }
    })
  end,
  lazy = true,
  keys = {
    { '<C-f><C-f>', ':Neotree current reveal<CR>' },
    { '<C-f>f', ':Neotree current reveal<CR>' },
    { '<C-f><C-v>', ':vsplit<bar>Neotree current reveal<CR>' },
    { '<C-f>v', ':vsplit<bar>Neotree current reveal<CR>' },
    { '<C-f><C-x>', ':split<bar>Neotree current reveal<CR>' },
    { '<C-f>x', ':split<bar>Neotree current reveal<CR>' },
    { '<C-f><C-h>', ':split<bar>Neotree current reveal<CR>' },
    { '<C-f>h', ':split<bar>Neotree current reveal<CR>' },
    { '<C-f><C-t>', ':tabedit %<bar>Neotree current reveal<CR>' },
    { '<C-f>t', ':tabedit %<bar>Neotree current reveal<CR>' },
  }
}
