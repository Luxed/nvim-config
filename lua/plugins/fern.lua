local map = require('helpers.map')

vim.g['fern#renderer'] = 'nerdfont'
vim.g['fern#default_hidden'] = 1
vim.g['fern#default_exclude'] = '.git'

local function f_map(key, opener)
  map.nnore('<C-f>' .. key, ':Fern . -reveal=% -opener=' .. opener .. '<CR>', { silent = true })
  map.nnore('<C-f><C-' .. key .. '>', ':Fern . -reveal=% -opener=' .. opener .. '<CR>', { silent = true })
end

f_map('f', 'edit')
f_map('v', 'vsplit')
f_map('h', 'split')
f_map('x', 'split')
f_map('t', 'tabedit')
