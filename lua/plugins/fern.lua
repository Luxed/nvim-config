local map = require('helpers.map')

vim.g['fern#renderer'] = 'nerdfont'
vim.g['fern#default_hidden'] = 1
vim.g['fern#default_exclude'] = '.git'

map.nnore('<C-f>f', ':Fern . -reveal=%<CR>', { silent = true })
map.nnore('<C-f><C-f>', ':Fern . -reveal=%<CR>', { silent = true })
--map.nnore('<C-f>v', ':Fern . -reveal=% -opener=vertical\\ leftabove\\ split<CR>', { silent = true })
map.nnore('<C-f>v', ':Fern . -reveal=% -opener=vsplit<CR>', { silent = true })
map.nnore('<C-f><C-v>', ':Fern . -reveal=% -opener=vsplit<CR>', { silent = true })
map.nnore('<C-f>h', ':Fern . -reveal=% -opener=split<CR>', { silent = true })
map.nnore('<C-f><C-h>', ':Fern . -reveal=% -opener=split<CR>', { silent = true })
