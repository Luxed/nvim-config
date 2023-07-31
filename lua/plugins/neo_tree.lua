-- TODO: Once again I'm having issues with my file explorer. It seems like I've never found something that truly works for me and doesn't break all the time.
-- Here's a new list of requirements:
-- * Can be opened in the current buffer or in a new split. Opening in the "drawer" mode is completely useless to me.
-- * Doesn't override too many keys so I can use the file explorer like a read-only buffer.
-- * Integrates with Git (optional tbh)
-- * Has file icons (pretty important, it really helps me)
-- * Doesn't have to be in Lua. At the end of the day, not everything needs to be in Lua. If that means I go back to Fern or NERDTree, then that's fine. I just want something that works.
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
