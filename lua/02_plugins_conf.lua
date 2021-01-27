local g = vim.g
local au = require('helpers.command').autocmd
local map = require('helpers.map')

local function languages()
  -- Pandoc
  g['pandoc#modules#disabled'] = {'spell'}

  au('FileType', 'css,scss', 'setlocal iskeyword+=-')
end

local function utility()
  -- NerdTree
  map.nore('', '<C-N>', ':NERDTreeToggle<CR>')
  g['NERDTreeShowHidden'] = 1

  -- Switch
  map.nnore('<leader>ss', ':call switcher#Switch()<CR>')
  map.nnore('<leader>sv', ':call switcher#SwitchWithOptions({"edit_command": "vs"})<CR>')
  map.nnore('<leader>sh', ':call switcher#SwitchWithOptions({"edit_command": "sp"})<CR>')

  -- Wrap
  map.xnore('<leader>w', ':call wrap#func()<CR>')

  -- Fugitive
  map.nnore('<leader>gs', ':Gstatus<CR>', {silent = true})
  map.nnore('<leader>gf', ':Git fetch<CR>', {silent = true})

  -- vim-closetag
  g['closetag_filenames'] = '*.html,*.xhtml,*.phtml,*.vue,*.xml'
  g['closetag_filetypes'] = 'html,xhtml,phtml,vue,xml'

  -- vsnip
  local function vsnip_mapper(keymap, expr, on_true)
    map.multi({'i', 's'}, keymap, string.format('%s ? \'%s\' : \'%s\'', expr, on_true, keymap), {expr = true})
  end
  vsnip_mapper('<C-e>', 'vsnip#expandable()', '<Plug>(vsnip-expand)')
  vsnip_mapper('<C-j>', 'vsnip#jumpable(1)', '<Plug>(vsnip-jump-next)')
  vsnip_mapper('<C-k>', 'vsnip#jumpable(-1)', '<Plug>(vsnip-jump-prev)')
end

local function interface()
  require('plugins.airline')

  require('plugins.startify')

  -- Semshi
  g['semshi#error_sign'] = false
  g['semshi#always_update_all_highlights'] = false

  -- Pencil
  g['pencil_higher_contrast_ui'] = 1
  g['pencil_gutter_color'] = 0

  -- Ayu
  g['ayucolor'] = 'mirage'

  -- CtrlSF
  g['ctrlsf_populate_qflist'] = true
  --g['ctrlsf_default_view_mode'] = 'compact'

  -- git-blame.nvim
  g['gitblame_enabled'] = 0
end

local function lua_plugins()
  require('plugins.telescope').init()
  -- completion-nvim
  au('BufEnter', '*', 'lua require("completion").on_attach(require("plugins.completion").options)')
  require('plugins.completion').setup_mappings()

  require('plugins.lsp_status')
  require('plugins.lsp')
  require('plugins.colorizer')
  require('plugins.treesitter')

  require('plugins.galaxyline')
  require('plugins.bufferline')
end

languages()
utility()
interface()
lua_plugins()
