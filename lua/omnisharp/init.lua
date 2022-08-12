local function request_highlight(client)
  local bufnr = vim.api.nvim_get_current_buf()

  local params = {
    fileName = vim.fn.expand('%:p'),
    column = 1,
    line = 1
  }
  client.request('o#/v2/highlight', params, require('omnisharp.highlight').__highlight_handler, bufnr)
end

local function setup_highlight_autocmds(config)
  local highlight_callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local clients = vim.lsp.get_active_clients({
      bufnr = bufnr,
      name = 'omnisharp'
    })

    if #clients == 1 then
      local client = clients[1]
      request_highlight(client)
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

return {
  setup = function(lsp_opts, config)
    config = vim.tbl_extend('force', get_default_config(), config or {})

    require('omnisharp.highlight').__setup_highlight_groups(config)

    if config.solution_first then
      lsp_opts.root_dir = function(path)
        local root_pattern = require('lspconfig.util').root_pattern
        -- Make sure an sln doesn't already exist before trying to use the nearest csproj file
        return root_pattern('*.sln')(path) or root_pattern('*.csproj')(path)
      end
    end

    if lsp_opts.on_attach then
      local existing_attach = lsp_opts.on_attach
      lsp_opts.on_attach = function(client)
        existing_attach(client)

        if config.highlight then
          setup_highlight_autocmds(config)
          request_highlight(client)
        end
      end
    elseif config.highlight then
      lsp_opts.on_attach = function(client)
        setup_highlight_autocmds(config)
        request_highlight(client)
      end
    end

    require('lspconfig').omnisharp.setup(lsp_opts)
  end,
  highlight = function()
    local client = vim.lsp.get_client_by_id(1)
    request_highlight(client)
  end
}
