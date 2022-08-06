local config_path = vim.fn.stdpath('config')
vim.g['vsnip_snippet_dir'] = config_path .. '/vsnip'

require('keymaps').vsnip()
