return {
  vanilla = function()
    vim.g.mapleader = ','
    vim.keymap.set('n', ';', ':')
    vim.keymap.set('n', '<leader>l', ':bnext<CR>')
    vim.keymap.set('n', '<leader>h', ':bprevious<CR>')
    vim.keymap.set('n', '<leader>bq', ':b# <BAR> bd #<CR>')
    vim.keymap.set('n', '<leader>th', ':set hlsearch!<CR>')
    vim.keymap.set('n', '<leader>tw', ':setlocal wrap!<CR>')
    vim.keymap.set('n', '<leader>n', ':nohl<CR>')
    vim.keymap.set('n', '<leader>N', ':Rmhl<CR>')
    vim.keymap.set('n', 'zS', function() require('helpers.syntax').showCursorHighlights() end)

    vim.keymap.set('n', '<space>', 'za', {remap = true})
    vim.keymap.set('n', '<C-space>', 'zA', {remap = true})

    -- Switch
    vim.keymap.set('n', '<leader>ss', ':call switcher#Switch()<CR>')
    vim.keymap.set('n', '<leader>sv', ':call switcher#SwitchWithOptions({"edit_command": "vs"})<CR>')
    vim.keymap.set('n', '<leader>sh', ':call switcher#SwitchWithOptions({"edit_command": "sp"})<CR>')

    -- Wrap
    vim.keymap.set('x', '<leader>w', ':call wrap#func()<CR>')

    if vim.fn.has('win32') == 1 then
      -- Because Windows is such a great operating system,
      -- doing <C-Z> will completely lock up Neovim in the terminal.
      -- See: https://github.com/neovim/neovim/issues/6660
      vim.keymap.set('n', '<C-Z>', function() require('term').open() end)
    end

    vim.keymap.set('t', '<leader>n', '<C-\\><C-N>')
  end,
  fugitive = function()
    vim.keymap.set('n', '<leader>gs', ':Git<CR>', {silent = true})
    vim.keymap.set('n', '<leader>gf', ':Git fetch<CR>', {silent = true})
  end,
  fugitive_buffer = function()
    vim.keymap.set('n', '<leader>gp', ':Git push<CR>', {buffer = true})
  end,
  fern = function()
    local function f_map(key, opener)
      vim.keymap.set('n', '<C-f>' .. key, ':Fern . -reveal=% -opener=' .. opener .. '<CR>', { silent = true })
      vim.keymap.set('n', '<C-f><C-' .. key .. '>', ':Fern . -reveal=% -opener=' .. opener .. '<CR>', { silent = true })
    end

    f_map('f', 'edit')
    f_map('v', 'vsplit')
    f_map('h', 'split')
    f_map('x', 'split')
    f_map('t', 'tabedit')
  end,
  vsnip = function()
    local function v_map(key, expr, on_true)
      vim.keymap.set({'i', 's'}, key, string.format('%s ? \'%s\' : \'%s\'', expr, on_true, key), {expr = true})
    end

    v_map('<C-e>', 'vsnip#expandable()', '<Plug>(vsnip-expand)')
    v_map('<C-j>', 'vsnip#jumpable(1)', '<Plug>(vsnip-jump-next)')
    v_map('<C-k>', 'vsnip#jumpable(-1)', '<Plug>(vsnip-jump-prev)')
  end,
  telescope = function()
    local builtin = require('telescope.builtin')
    local fix_folds = require('plugins.telescope').fix_folds

    vim.keymap.set('n', '<leader>ff', function() builtin.find_files(fix_folds) end)
    vim.keymap.set('n', '<leader>fb', function() builtin.buffers({ show_all_buffers = true }) end)
    vim.keymap.set('n', '<leader>fg', function() require('plugins.telescope').rg(fix_folds) end)
    vim.keymap.set('n', '<leader>gb', builtin.git_branches)
    vim.keymap.set('n', '<leader>gt', function() require('plugins.telescope').tags() end)
  end,
  lsp = function(client)
    vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end)

    vim.keymap.set('n', '<leader>qk', function() vim.lsp.buf.hover() end)
    vim.keymap.set('n', '<leader>qK', function() vim.lsp.buf.signature_help() end)
    vim.keymap.set('n', '<leader>qq', function() vim.diagnostic.open_float() end)
    if vim.fn.has('nvim-0.8') == 1 then
      vim.keymap.set('n', '<leader>qr', ':IncRename ')
    else
      vim.keymap.set('n', '<leader>qr', function() vim.lsp.buf.rename() end)
    end
    vim.keymap.set('n', '<leader>qn', function() vim.diagnostic.goto_next() end)
    vim.keymap.set('n', '<leader>qp', function() vim.diagnostic.goto_prev() end)
    vim.keymap.set('n', '<leader>qa', function() vim.lsp.buf.code_action() end)

    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>qgr', function() builtin.lsp_references() end)
    vim.keymap.set('n', '<leader>qs', function() builtin.lsp_document_symbols() end)
    vim.keymap.set('n', '<leader>qd', function() builtin.lsp_document_diagnostics() end)
    vim.keymap.set('n', '<leader>qwd', function() builtin.lsp_workspace_diagnostics() end)
    vim.keymap.set('n', '<leader>qws', function() builtin.lsp_workspace_symbols() end)
    vim.keymap.set('n', '<leader>qgi', function() builtin.lsp_implementations() end)

    if client.name == 'omnisharp' then
      vim.keymap.set('n', 'gd', function() require('omnisharp_extended').telescope_lsp_definitions() end)
    else
      vim.keymap.set('n', 'gd', function() builtin.lsp_definitions() end)
    end
  end,
  indent_blankline = function()
    local function remap(lhss)
      for _,lhs in pairs(lhss) do
        vim.keymap.set('n', lhs, lhs .. ':IndentBlanklineRefresh<CR>', { silent = true })
      end
    end

    remap({'zo', 'zO', 'zc', 'zC', 'za', 'zA', 'zv', 'zx', 'zX', 'zm', 'zM', 'zR', 'zr'})
  end,
  term = function(new_term)
    vim.keymap.set('t', '<leader>n', '<C-\\><C-N>:b#<CR>', { silent = true, buffer = new_term })
  end,
}
