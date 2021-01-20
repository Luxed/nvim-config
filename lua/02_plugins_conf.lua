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
  -- Airline
  g['airline_powerline_fonts'] = 1
  g['airline#extensions#tabline#enabled'] = 1
  g['airline#extensions#tabline#fnamemod'] = ':t'
  g['airline#extensions#tabline#tab_nr_type'] = 1
  g['airline#extensions#tabline#show_tab_nr'] = 1
  g['airline_mode_map'] = {
    ['__'] = '------',
    ['c']  = 'COMMAND',
    ['i']  = 'INSERT',
    ['ic'] = 'INSERT',
    ['ix'] = 'INSERT',
    ['n']  = 'NORMAL',
    ['ni'] = '(INSERT)',
    ['no'] = 'OP PENDING',
    ['R']  = 'REPLACE',
    ['Rv'] = 'V REPLACE',
    ['s']  = 'SELECT',
    ['S']  = 'S-LINE',
    [''] = 'S-BLOCK',
    ['t']  = '>_',
    ['v']  = 'VISUAL',
    ['V']  = 'V-LINE',
    [''] = 'V-BLOCK',
  }

  -- Telescope
  map.nnore('<leader>ff', ':lua require("telescope.builtin").find_files({})<CR>')
  map.nnore('<leader>fb', ':lua require("telescope.builtin").buffers({show_all_buffers = true})<CR>')
  map.nnore('<leader>fg', ':lua require("plugins.telescope").rg()<CR>')
  --map.nnore('<leader>gb', ':lua require("plugins.telescope").branch({})<CR>')
  map.nnore('<leader>gb', ':lua require("telescope.builtin").git_branches()<CR>')
  map.nnore('<leader>gt', ':lua require("plugins.telescope").tags({})<CR>')

  -- Startify
  -- ensure vim-startify is loaded
  vim.cmd('packadd vim-startify')

  g['startify_change_to_dir'] = 0
  g['startify_custom_header'] = {
    [[  _   _                 _           ]],
    [[ | \ | |               (_)          ]],
    [[ |  \| | ___  _____   ___ _ __ ___  ]],
    [[ | . ` |/ _ \/ _ \ \ / / | '_ ` _ \ ]],
    [[ | |\  |  __/ (_) \ V /| | | | | | |]],
    [[ |_| \_|\___|\___/ \_/ |_|_| |_| |_|]],
    [[                                    ]],
    unpack(vim.fn['startify#fortune#boxed']())
  }
  g['startify_lists'] = {
    { type = 'dir',       header = {'   MRU ' .. vim.fn.getcwd()} },
    { type = 'files',     header = {'   MRU'}            },
    { type = 'sessions',  header = {'   Sessions'}       },
    { type = 'bookmarks', header = {'   Bookmarks'}      },
    { type = 'commands',  header = {'   Commands'}       },
  }

  -- Semshi
  g['semshi#error_sign'] = 0
  g['semshi#always_update_all_highlights'] = 0

  -- Pencil
  g['pencil_higher_contrast_ui'] = 1
  g['pencil_gutter_color'] = 0
end

local function lua_plugins()
  -- completion-nvim
  au('BufEnter', '*', 'lua require("completion").on_attach(require("plugins.completion").options)')
  require('plugins.completion').setup_mappings()

  -- lsp (builtin)
  local function on_attach_lsp()
    local silent_opts = {silent = true}
    map.nnore('<leader>qk', '<cmd>lua vim.lsp.buf.hover()<CR>', silent_opts, true)
    map.nnore('K', '<cmd>lua vim.lsp.buf.hover()<CR>', silent_opts, true)
    map.nnore('<leader>qK', '<cmd>lua vim.lsp.buf.signature_help()<CR>', silent_opts, true)
    map.nnore('<leader>qq', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', silent_opts, true)
    --map.nnore('<leader>qgr', '<cmd>lua vim.lsp.buf.references()<CR>', silent_opts, true)
    map.nnore('<leader>qgd', '<cmd>lua vim.lsp.buf.definition()<CR>', silent_opts, true)
    map.nnore('<leader>qgi', '<cmd>lua vim.lsp.buf.implementation()<CR>', silent_opts, true)
    map.nnore('<leader>qr', '<cmd>lua vim.lsp.buf.rename()<CR>', {}, true)
    --map.nnore('<leader>qa', '<cmd>lua vim.lsp.buf.code_action()<CR>', {}, true)
    map.nnore('<leader>qn', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', {}, true)
    map.nnore('<leader>qp', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', {}, true)
    map.nnore('<leader>qd', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', {}, true)

    -- use Telescope for more convenient and consistent UI
    map.nnore('<leader>qgr', '<cmd>lua require("telescope.builtin").lsp_references()<CR>', {}, true)
    map.nnore('<leader>qa', '<cmd>lua require("telescope.builtin").lsp_code_actions()<CR>', {}, true)
    map.nnore('<leader>qs', '<cmd>lua require("telescope.builtin").lsp_document_symbols()<CR>', {}, true)

    -- override default keymap
    vim.api.nvim_buf_set_keymap(0, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', {})

    au('CursorHold',  '<buffer>', 'lua vim.lsp.buf.document_highlight()')
    au('CursorHoldI', '<buffer>', 'lua vim.lsp.buf.document_highlight()')
    au('CursorMoved', '<buffer>', 'lua vim.lsp.buf.clear_references()')
  end

  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      underline = true,
      virtual_text = {
        spacing = 5,
        prefix = ' '
      },
      signs = true,
      update_in_insert = false
    })

  -- lspconfig
  local nvim_lsp = require('lspconfig')
  nvim_lsp.vuels.setup{on_attach = on_attach_lsp}
  nvim_lsp.rls.setup{on_attach = on_attach_lsp}
  nvim_lsp.tsserver.setup{on_attach = on_attach_lsp}
  nvim_lsp.vimls.setup{on_attach = on_attach_lsp}
  nvim_lsp.html.setup{on_attach = on_attach_lsp}
  --nvim_lsp.jdtls.setup{}
  -- TODO: make this work for Linux and Windows
  local pid = vim.fn.getpid()
  local home = vim.fn.expand('~')
  local omnisharp_bin = home .. '/.local/opt/omnisharp-server/run'
  nvim_lsp.omnisharp.setup{
    cmd = { omnisharp_bin, '--languageserver', '--hostPID', tostring(pid) },
    on_attach = on_attach_lsp
  }
  require('nlua.lsp.nvim').setup(require('lspconfig'), {on_attach = on_attach_lsp})

  -- colorizer
  require('colorizer').setup({
      dosini = {
        names = false;
        mode = 'background';
      },
      cfg = {
        names = false;
        RRGGBBAA = true;
      }
    })

end

languages()
utility()
interface()
lua_plugins()
