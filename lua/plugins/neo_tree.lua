require('neo-tree').setup({
  filesystem = {
    hijack_netrw_behavior = 'open_current'
  }
})

require('keymaps').neotree()
