local map = require('helpers.map')

map.nnore('<leader>gs', ':Git<CR>', {silent = true})
map.nnore('<leader>gf', ':Git fetch<CR>', {silent = true})
