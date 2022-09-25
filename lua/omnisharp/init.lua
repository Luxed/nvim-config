local log = require('omnisharp.log')
local request = require('omnisharp.request')

-- TODO: When switching from a C# file to a file that doesn't use TreeSitter (like an XML file (the csproj)), the highlights stay.
local function setup_highlight_autocmds(config)
  local highlight_callback = function()
    request.highlight(nil, require('omnisharp.highlight').__highlight_handler)
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
    solution_first = false, -- Find the .sln file first then fallback to the csproj
    automatic_dap_configuration = false,
    highlight = {
      enabled = false,
      refresh_mode = 'normal', -- 'normal' or 'insert'
      groups = nil
    },
    server = {}
  }
end

local function get_default_groups()
  -- TODO: Maybe add a way to use Treesitter groups instead?
  -- Once the offical support comes and there is a plugin that most people are using, or if the groups are included directly in neovim,
  -- then the plugin will be changed to be using those by default since it will make the most sense.
  return {
    OmniSharpComment = {link = 'Comment'},
    OmniSharpIdentifier = {link = 'Identifier'},
    OmniSharpKeyword = {link = 'Keyword'},
    OmniSharpControlKeyword = {link = 'Conditional'},
    OmniSharpNumericLiteral = {link = 'Number'},
    OmniSharpOperator = {link = 'Operator'},
    OmniSharpOperatorOverloaded = {link = 'Operator'},
    OmniSharpPreprocessorKeyword = {link = 'PreProc'},
    OmniSharpPreprocessorText = {link = 'String'},
    OmniSharpStringLiteral = {link = 'String'},
    OmniSharpText = {link = 'String'},
    OmniSharpVerbatimStringLiteral = {link = 'String'},
    OmniSharpStringEscapeCharacter = {link = 'Special'},
    OmniSharpClassName = {link = 'Type'},
    OmniSharpEnumName = {link = 'Type'},
    OmniSharpInterfaceName = {link = 'Type'},
    OmniSharpStructName = {link = 'Type'},
    OmniSharpConstantName = {link = 'Constant'},
    OmniSharpMethodName = {link = 'Function'},
    OmniSharpExtensionMethodName = {link = 'Function'},
    OmniSharpNamespaceName = {link = 'Include'},
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
  setup = function(config)
    config = vim.tbl_deep_extend('force', get_default_config(), config or {})
    config.highlight.groups = vim.tbl_extend('force', get_default_groups(), config.highlight.groups or {})

    require('omnisharp.highlight').__setup_highlight_groups(config)

    if config.solution_first then
      config.server.root_dir = function(path)
        local root_pattern = require('lspconfig.util').root_pattern
        -- Make sure an sln doesn't already exist before trying to use the nearest csproj file
        return root_pattern('*.sln')(path) or root_pattern('*.csproj')(path)
      end
    end

    config.server.on_attach = require('lspconfig.util').add_hook_after(config.server.on_attach, function(client)
      if config.highlight and config.highlight.enabled then
        setup_highlight_autocmds(config)
        request.highlight(client, require('omnisharp.highlight').__highlight_handler)
      end

      if config.automatic_dap_configuration then
        require('omnisharp.dap').configure_dap(client)
      end
    end)

    require('lspconfig').omnisharp.setup(config.server)
  end,
  fix_usings = function()
    request.fix_usings(nil, function(buffer)
      local normalized_buffer = string.gsub(buffer, '\r\n', '\n')
      local lines = split(normalized_buffer, '\n')

      -- TODO: This "works" but resets/deletes folds?
      vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
    end)
  end,
  show_highlights_under_cursor = function()
    request.highlight(nil, require('omnisharp.highlight').__show_highlight_handler)
  end,
  launch_debug = function()
    log.info('Launching "dotnet build"')
    vim.fn.jobstart('dotnet build', {
      cwd = vim.fn.expand('%:p:h'), -- This will use the path of the current buffer as the current working directory to ensure that only the current project is built instead of the entire solution (if that's where your Neovim instance was started)
      on_exit = function(chan_id, exit_code, name)
        if exit_code ~= 0 then
          log.error('"dotnet build" has failed. The debugging session will not be launched!')
        else
          log.info('Build finished, launching debugging session')
          require('omnisharp.dap').launch_current_configuration()
        end
      end
    })
  end,
  open_workspace_information = function()
    -- TODO: Information should be shown in a floating window similar to "LspInfo" instead of a floating preview next to the cursor
    request.projects(nil, function(workspace)
      local lines = {
        '# OmniSharp Workspace Information',
        '',
        'Solution Path: `' .. workspace.SolutionPath .. '`',
        '',
        '## Projects',
      }

      for _, project in pairs(workspace.Projects) do
        table.insert(lines, '')
        table.insert(lines, '### Project: ' .. project.AssemblyName)
        table.insert(lines, '')
        table.insert(lines, 'Project Path     : `' .. project.Path .. '`')
        table.insert(lines, 'Configuration    : `' .. project.Configuration .. '`')
        table.insert(lines, 'Is Executable    : `' .. tostring(project.IsExe) .. '`')
        table.insert(lines, 'Platform         : `' .. project.Platform .. '`')

        local frameworks = ''
        for _, framework in pairs(project.TargetFrameworks) do
          if frameworks ~= '' then
            frameworks = frameworks .. ';'
          end
          frameworks = frameworks .. framework.ShortName
        end

        table.insert(lines, 'Target Frameworks: `' .. frameworks .. '`')
        table.insert(lines, 'Target Path      : `' .. project.TargetPath .. '`')
      end

      vim.lsp.util.open_floating_preview(lines, 'markdown', {
        border = 'rounded',
        pad_left = 4,
        pad_right = 4
      })
    end)
  end
}
