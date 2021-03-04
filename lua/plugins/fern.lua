local map = require('helpers.map')

map.nnore('<C-f>f', ':Fern . -reveal=%<CR>', { silent = true })
map.nnore('<C-f>v', ':Fern . -reveal=% -opener=vertical\\ leftabove\\ split<CR>', { silent = true })
