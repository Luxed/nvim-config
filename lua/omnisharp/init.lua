local function request_highlight(client, handler)
  local bufnr = vim.api.nvim_get_current_buf()

  local params = {
    fileName = vim.fn.expand('%:p'),
    column = 1,
    line = 1
  }
  client.request('o#/v2/highlight', params, handler, bufnr)
end

local function get_current_omnisharp_client()
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_active_clients({
    bufnr = bufnr,
    name = 'omnisharp'
  })

  if #clients == 1 then
    return clients[1]
  end
end

local function setup_highlight_autocmds(config)
  local highlight_callback = function()
    local client = get_current_omnisharp_client()

    if client then
      request_highlight(client, require('omnisharp.highlight').__highlight_handler)
    end
  end

  local bufnr = vim.api.nvim_get_current_buf()
  local highlight_augroup = vim.api.nvim_create_augroup('omnisharp_highlight_' .. tostring(bufnr), {clear = true})
  vim.api.nvim_create_autocmd('BufEnter', {
    group = highlight_augroup,
    buffer = bufnr,
    callback = highlight_callback
  })
  vim.api.nvim_create_autocmd({'InsertLeave', 'TextChanged'}, {
    group = highlight_augroup,
    buffer = bufnr,
    callback = highlight_callback
  })

  if config.highlight.refresh_mode == 'insert' then
    vim.api.nvim_create_autocmd('TextChangedI', {
      group = highlight_augroup,
      buffer = bufnr,
      callback = highlight_callback
    })

    if vim.fn.exists('##TextChangedP') == 1 then
      vim.api.nvim_create_autocmd('TextChangedP', {
        group = highlight_augroup,
        buffer = bufnr,
        callback = highlight_callback
      })
    end
  end
end

local function get_default_config()
  return {
    solution_first = true, -- Find the .sln file first then fallback to the csproj
    highlight = {
      enabled = true,
      refresh_mode = 'normal',
      groups = {
        OmniSharpComment = {link = 'Comment'},
        OmniSharpIdentifier = {link = 'Identifier'},
        OmniSharpKeyword = {link = 'Keyword'},
        OmniSharpControlKeyword = {link = 'Keyword'},
        OmniSharpNumericLiteral = {link = 'Number'},
        OmniSharpOperator = {link = 'Operator'},
        OmniSharpOperatorOverloaded = {link = 'Operator'},
        OmniSharpStringLiteral = {link = 'String'},
        OmniSharpText = {link = 'String'},
        OmniSharpVerbatimStringLiteral = {link = 'String'},
        OmniSharpClassName = {link = 'Type'},
        OmniSharpEnumName = {link = 'Type'},
        OmniSharpInterfaceName = {link = 'Type'},
        OmniSharpStructName = {link = 'Type'},
        OmniSharpConstantName = {link = 'Constant'},
        OmniSharpMethodName = {link = 'Function'},
        OmniSharpExtensionMethodName = {link = 'Function'},
      }
    }
  }
end

local function split(str, delimiter)
  -- https://gist.github.com/jaredallard/ddb152179831dd23b230
  local result = { }
  local from  = 1
  local delim_from, delim_to = string.find(str, delimiter, from)
  while delim_from do
    table.insert(result, string.sub(str, from , delim_from-1))
    from  = delim_to + 1
    delim_from, delim_to = string.find(str, delimiter, from)
  end
  table.insert(result, string.sub(str, from))
  return result
end

return {
  setup = function(lsp_opts, config)
    config = vim.tbl_deep_extend('force', get_default_config(), config or {})

    require('omnisharp.highlight').__setup_highlight_groups(config)

    if config.solution_first then
      lsp_opts.root_dir = function(path)
        local root_pattern = require('lspconfig.util').root_pattern
        -- Make sure an sln doesn't already exist before trying to use the nearest csproj file
        return root_pattern('*.sln')(path) or root_pattern('*.csproj')(path)
      end
    end

    lsp_opts.on_attach = require('lspconfig.util').add_hook_after(lsp_opts.on_attach, function(client)
      if config.highlight and config.highlight.enabled then
        setup_highlight_autocmds(config)
        request_highlight(client, require('omnisharp.highlight').__highlight_handler)
      end
    end)

    require('lspconfig').omnisharp.setup(lsp_opts)
  end,
  fix_usings = function()
    local client = get_current_omnisharp_client()
    local params = {
      fileName = vim.fn.expand('%:p'),
      column = 1,
      line = 1
    }

    client.request('o#/fixusings', params, function(err, result, ctx, config)
      local normalized_buffer = string.gsub(result.Buffer, '\r\n', '\n')
      local lines = split(normalized_buffer, '\n')

      -- TODO: This "works" but resets/deletes folds?
      vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
    end, 0)
  end,
  show_highlights_under_cursor = function()
    local client = get_current_omnisharp_client()
    request_highlight(client, require('omnisharp.highlight').__show_highlight_handler)
  end
}
