local config_path = vim.api.nvim_get_var('config_path')

require('aniseed.compile').glob('**/*.fnl', config_path .. '/fnl', config_path .. '/lua')

require('init')
