local map = require('helpers.map')
local g = vim.g

-- Switch
map.nnore('<leader>ss', ':call switcher#Switch()<CR>')
map.nnore('<leader>sv', ':call switcher#SwitchWithOptions({"edit_command": "vs"})<CR>')
map.nnore('<leader>sh', ':call switcher#SwitchWithOptions({"edit_command": "sp"})<CR>')

-- Wrap
map.xnore('<leader>w', ':call wrap#func()<CR>')

-- Semshi
g['semshi#error_sign'] = false
g['semshi#always_update_all_highlights'] = false

-- Pencil
g['pencil_higher_contrast_ui'] = 1
g['pencil_gutter_color'] = 0

