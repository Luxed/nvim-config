return {
  vanilla = function()
    vim.g.mapleader = ','
    vim.keymap.set('n', ';', ':')
    vim.keymap.set('n', '<leader>l', ':bnext<CR>')
    vim.keymap.set('n', '<leader>h', ':bprevious<CR>')
    vim.keymap.set('n', '<leader>bq', ':b# <BAR> bd #<CR>')
    vim.keymap.set('n', '<leader>br', ':%s/<C-r><C-w>//g<left><left>')
    vim.keymap.set('n', '<leader>th', ':set hlsearch!<CR>')
    vim.keymap.set('n', '<leader>tw', ':setlocal wrap!<CR>')
    vim.keymap.set('n', '<leader>ts', ':setlocal spell!<CR>')
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

    -- Convenient Control+Backspace insert mode mapping
    vim.keymap.set('i', '<C-backspace>', '<esc>caw')
  end,
  fugitive = function()
    vim.keymap.set('n', '<leader>gs', ':Git<CR>', {silent = true})
    vim.keymap.set('n', '<leader>gf', ':Git fetch<CR>', {silent = true})
  end,
  fugitive_buffer = function()
    vim.keymap.set('n', '<leader>gp', ':Git push<CR>', {buffer = true})
  end,
  vsnip = function()
    local function v_map(key, condition, on_true)
      vim.keymap.set({'i', 's'}, key, function() return condition() ~= 0 and on_true or key end, {expr = true})
    end

    v_map('<C-e>', function() return vim.fn['vsnip#expandable']() end, '<Plug>(vsnip-expand)')
    v_map('<C-j>', function() return vim.fn['vsnip#jumpable'](1) end, '<Plug>(vsnip-jump-next)')
    v_map('<C-k>', function() return vim.fn['vsnip#jumpable'](-1) end, '<Plug>(vsnip-jump-prev)')
  end,
  luasnip = function()
    vim.keymap.set('i', '<C-e>', function() require('luasnip').expand_or_jump() end)
    vim.keymap.set({'i', 's'}, '<C-j>', function() require('luasnip').jump(1) end)
    vim.keymap.set({'i', 's'}, '<C-k>', function() require('luasnip').jump(-1) end)
  end,
  lsp = function(client)
    if client.name == 'rust_analyzer' then
      vim.keymap.set('n', 'K', function() require('rust-tools.hover_actions').hover_actions() end)
      vim.keymap.set('n', '<leader>qk', function() require('rust-tools.hover_actions').hover_actions() end)
    else
      vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end)
      vim.keymap.set('n', '<leader>qk', function() vim.lsp.buf.hover() end)
    end

    vim.keymap.set('n', '<leader>qK', function() vim.lsp.buf.signature_help() end)
    vim.keymap.set('n', '<leader>qq', function() vim.diagnostic.open_float() end)
    vim.keymap.set('n', '<leader>qr', function() vim.lsp.buf.rename() end)
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
  comments = function()
    local esc = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)
    vim.keymap.set('n', '<leader>cc', function() require('Comment.api').toggle.linewise.current() end)
    vim.keymap.set('n', '<leader>cu', function() require('Comment.api').uncomment.linewise.current() end)

    vim.keymap.set('x', '<leader>cm', function()
      vim.api.nvim_feedkeys(esc, 'nx', false)
      require('Comment.api').toggle.blockwise(vim.fn.visualmode())
    end)
    vim.keymap.set('x', '<leader>cc', function()
      vim.api.nvim_feedkeys(esc, 'nx', false)
      require('Comment.api').toggle.linewise(vim.fn.visualmode())
    end)
    vim.keymap.set('x', '<leader>cu', function()
      vim.api.nvim_feedkeys(esc, 'nx', false)
      local ft = require('Comment.ft')
      local u = require('Comment.utils')
      if not ft.get(vim.bo.filetype, u.ctype.blockwise) then
        require('Comment.api').uncomment.linewise(vim.fn.visualmode())
      else
        require('Comment.api').uncomment.blockwise(vim.fn.visualmode())
      end
    end)
  end
}
