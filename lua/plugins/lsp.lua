-- Plugins require
local nvim_lsp = require('lspconfig')
local lsp_status = require('lsp-status')
--local lsp_signature = require('lsp_signature')
local root_pattern = require('lspconfig.util').root_pattern
-- Local require
local buf_command = require('helpers.command').buf_command
local augroup = require('helpers.command').augroup
local map = require('helpers.map')
local home = vim.fn.expand('~')

local function on_attach_keymaps()
  local builtin = require('telescope.builtin')

  local m = map.buf.lua

  m('n', '<leader>qk', function() vim.lsp.buf.hover() end)
  m('n', 'K', function() vim.lsp.buf.hover() end)
  m('n', '<leader>qK', function() vim.lsp.buf.signature_help() end)
  m('n', '<leader>qq', function() vim.lsp.diagnostic.show_line_diagnostics() end)
  m('n', '<leader>qgd', function() vim.lsp.buf.definition() end)
  m('n', '<leader>qgi', function() vim.lsp.buf.implementation() end)
  m('n', '<leader>qr', function() vim.lsp.buf.rename() end)
  m('n', '<leader>qn', function() vim.lsp.diagnostic.goto_next() end)
  m('n', '<leader>qp', function() vim.lsp.diagnostic.goto_prev() end)

  -- use Telescope for more convenient and consistent UI
  m('n', '<leader>qgr', function() builtin.lsp_references() end)
  m('n', '<leader>qs', function() builtin.lsp_document_symbols() end)
  m('n', '<leader>qd', function() builtin.lsp_document_diagnostics() end)
  m('n', '<leader>qwd', function() builtin.lsp_workspace_diagnostics() end)
  m('n', '<leader>qws', function() builtin.lsp_workspace_symbols() end)

  if vim.o.filetype == 'cs' then
    m('n', 'gd', function() require('omnisharp_extended').telescope_lsp_definitions() end)
    -- TODO: temporary, Telescope sometimes deadlocks the vim instance when asked for code actions...
    m('n', '<leader>qa', function() vim.lsp.buf.code_action() end)
  else
    m('n', 'gd', function() vim.lsp.buf.definition() end)
    m('n', '<leader>qa', function() require("plugins.telescope").code_actions() end)
  end

  buf_command('Format', 'lua vim.lsp.buf.formatting()')
end

local function on_attach_complete(client)
  local bufnr = vim.fn.bufnr()
  -- NOTE: Some lsp (like omnisharp for example) will _crash_ instead of doing nothing when asked for highlight
  if client.resolved_capabilities.document_highlight then
    augroup('lsp_document_highlight_' .. tostring(bufnr), {
        { 'CursorHold', '<buffer>', 'lua vim.lsp.buf.document_highlight()' },
        { 'CursorMoved', '<buffer>', 'lua vim.lsp.buf.clear_references()' }
      })
  end
  augroup('lsp_lightbulb_' .. tostring(bufnr), {
      { 'CursorMoved,CursorMovedI', '<buffer>', 'lua require("nvim-lightbulb").update_lightbulb()' }
    })
  on_attach_keymaps()

  lsp_status.on_attach(client)

  --[[lsp_signature.on_attach({
      bind = true,
      hint_prefix = '',
      --hi_parameter = 'IncSearch',
      handler_opts = {
        border = 'none'
      }
    })]]
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    virtual_text = {
      spacing = 5,
      prefix = ' '
    },
    signs = true,
    update_in_insert = false
  })

local lsp_capabilities = lsp_status.capabilities
lsp_capabilities.textDocument.completion.completionItem.snippetSupport = true
lsp_capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits'
  }
}
lsp_capabilities = require('cmp_nvim_lsp').update_capabilities(lsp_capabilities)

local complete_lsp_setup = {
  on_attach = on_attach_complete,
  capabilities = lsp_capabilities
}

local extended_setup = function(additional_options)
  additional_options = additional_options or {}

  return vim.tbl_extend('force', complete_lsp_setup, additional_options)
end
  
-- NOTE: On windows, some commands created by npm will not work unless you explicitely tell lspconfig to use the ".cmd" executable
nvim_lsp.vuels.setup(extended_setup({
      cmd = vim.g.vls_cmd or {'vls'},
      init_options = {
        config = {
          vetur = {
            experimental = {
              templateInterpolationService = true
            }
          }
        }
      }
  }))
nvim_lsp.cssls.setup(extended_setup({
      cmd = vim.g.cssls_cmd
  }))
--nvim_lsp.rls.setup(complete_lsp_setup)
nvim_lsp.rust_analyzer.setup(extended_setup({
      cmd = vim.g.rust_analyzer_cmd or {'rust-analyzer'}
  }))
nvim_lsp.powershell_es.setup(extended_setup({
      -- TODO: will not work on Windows
      bundle_path = home .. '/.local/opt/PowerShellEditorServices'
  }))

nvim_lsp.vimls.setup(complete_lsp_setup)
nvim_lsp.bashls.setup(complete_lsp_setup)
nvim_lsp.pylsp.setup(complete_lsp_setup)
nvim_lsp.dockerls.setup(complete_lsp_setup)
nvim_lsp.jsonls.setup(complete_lsp_setup)

if vim.fn.has('win32') == 1 then
  -- For some reason, npm on Windows doesn't have a normal executable, only a .cmd and .ps1. To avoid issues, it is important to specify the .cmd so it doesn't fail when trying to start the server. Since this is not an issue on Linux, we only apply these changes on Windows.
  local function build_angular_cmd(node_path)
    return { 'ngserver.cmd', '--stdio', '--tsProbeLocations', node_path, '--ngProbeLocations', node_path }
  end

  nvim_lsp.angularls.setup(extended_setup({
        cmd = build_angular_cmd(),
        root_dir = function(path)
          return root_pattern('angular.json')(path)
        end,
        on_new_config = function(new_config, new_root_dir)
          new_config.cmd = build_angular_cmd(new_root_dir)
        end
    }))

  nvim_lsp.html.setup(extended_setup({
        cmd = { 'vscode-html-language-server.cmd', '--stdio' }
    }))

  nvim_lsp.yamlls.setup(extended_setup({
        cmd = { 'yaml-language-server.cmd', '--stdio' }
    }))
else
  nvim_lsp.angularls.setup(complete_lsp_setup)
  nvim_lsp.html.setup(complete_lsp_setup)
  nvim_lsp.yamlls.setup(complete_lsp_setup)
end

require('nlua.lsp.nvim').setup(nvim_lsp, complete_lsp_setup)

if vim.g.config_omnisharp_bin then
  local pid = vim.fn.getpid()
  nvim_lsp.omnisharp.setup(extended_setup({
    cmd = { vim.g.config_omnisharp_bin, '--languageserver', '--hostPID', tostring(pid) },
    root_dir = function(path)
      -- Make sure an sln doesn't already exist before trying to use the nearest csproj file
      return root_pattern('*.sln')(path) or root_pattern('*.csproj')(path)
    end,
    handlers = {
      ['textDocument/definition'] = require('omnisharp_extended').handler
    }
  }))
end

nvim_lsp.tsserver.setup{
  on_attach = function(client)
    on_attach_complete(client)

    local ts_utils = require('nvim-lsp-ts-utils')

    ts_utils.setup{
      debug = false,
      disable_commands = false,

      update_imports_on_move = true
    }
    ts_utils.setup_client(client)
  end,
  capabilities = lsp_capabilities
}

local data_path = vim.fn.stdpath('data')
nvim_lsp.rescriptls.setup(extended_setup({
  cmd = { 'node', data_path .. '/site/pack/packer/start/vim-rescript/server/out/server.js', '--stdio' }
}))

vim.fn.sign_define('DiagnosticSignError'           , { text='' })
vim.fn.sign_define('DiagnosticSignWarn'            , { text='' })
vim.fn.sign_define('DiagnosticSignInfo'            , { text='' })
vim.fn.sign_define('DiagnosticSignHint'            , { text='ﯦ' })
vim.fn.sign_define('LspDiagnosticsSignError'       , { text='' })
vim.fn.sign_define('LspDiagnosticsSignWarning'     , { text='' })
vim.fn.sign_define('LspDiagnosticsSignInformation' , { text='' })
vim.fn.sign_define('LspDiagnosticsSignHint'        , { text='ﯦ' })
vim.fn.sign_define('LightBulbSign'                 , { text='' })
