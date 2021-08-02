local map = require('helpers.map')
local config_path = vim.fn.stdpath('config')

-- vsnip
local function vsnip_mapper(keymap, expr, on_true)
  map.multi({'i', 's'}, keymap, string.format('%s ? \'%s\' : \'%s\'', expr, on_true, keymap), {expr = true})
end
vsnip_mapper('<C-e>', 'vsnip#expandable()', '<Plug>(vsnip-expand)')
vsnip_mapper('<C-j>', 'vsnip#jumpable(1)', '<Plug>(vsnip-jump-next)')
vsnip_mapper('<C-k>', 'vsnip#jumpable(-1)', '<Plug>(vsnip-jump-prev)')
vim.g['vsnip_snippet_dir'] = config_path .. '/vsnip'
