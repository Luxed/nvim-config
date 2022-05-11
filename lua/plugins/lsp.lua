local lsp_status = require('lsp-status')

local function on_attach_keymaps()
  local builtin = require('telescope.builtin')
  local buf_command = require('helpers.command').buf_command

  local m = require('helpers.map').buf.lua

  m('n', '<leader>qk', function() vim.lsp.buf.hover() end)
  m('n', 'K', function() vim.lsp.buf.hover() end)
  m('n', '<leader>qK', function() vim.lsp.buf.signature_help() end)
  m('n', '<leader>qq', function() vim.diagnostic.open_float() end)
  m('n', '<leader>qr', function() vim.lsp.buf.rename() end)
  m('n', '<leader>qn', function() vim.diagnostic.goto_next() end)
  m('n', '<leader>qp', function() vim.diagnostic.goto_prev() end)

  -- use Telescope for more convenient and consistent UI
  m('n', '<leader>qgr', function() builtin.lsp_references() end)
  m('n', '<leader>qs', function() builtin.lsp_document_symbols() end)
  m('n', '<leader>qd', function() builtin.lsp_document_diagnostics() end)
  m('n', '<leader>qwd', function() builtin.lsp_workspace_diagnostics() end)
  m('n', '<leader>qws', function() builtin.lsp_workspace_symbols() end)
  m('n', '<leader>qgi', function() builtin.lsp_implementations() end)

  if vim.o.filetype == 'cs' then
    m('n', 'gd', function() require('omnisharp_extended').telescope_lsp_definitions() end)
  else
    m('n', 'gd', function() vim.lsp.buf.definition() end)
  end

  --m('n', '<leader>qa', function() require("plugins.telescope").code_actions() end)
  m('n', '<leader>qa', function() vim.lsp.buf.code_action() end)

  buf_command('Format', 'lua vim.lsp.buf.formatting()')
end

local function on_attach_complete(client)
  local bufnr = vim.fn.bufnr()
  local augroup = require('helpers.command').augroup

  -- NOTE: Some lsp (like omnisharp for example) will _crash_ instead of doing nothing when asked for highlight
  if client.server_capabilities['documentHighlightProvider'] then
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

  require('lsp_signature').on_attach({
      bind = true,
      hint_prefix = '',
      hi_parameter = 'IncSearch',
      handler_opts = {
        border = 'single'
      }
    })
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

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "single"
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signatureHelp, {
  border = "single"
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

local function extended_setup(additional_options)
  additional_options = additional_options or {}

  return vim.tbl_extend('force', complete_lsp_setup, additional_options)
end
  
require('nvim-lsp-installer').on_server_ready(function (server)
  if server.name == 'omnisharp' then
    server:setup(extended_setup({
      root_dir = function(path)
        local root_pattern = require('lspconfig.util').root_pattern
        -- Make sure an sln doesn't already exist before trying to use the nearest csproj file
        return root_pattern('*.sln')(path) or root_pattern('*.csproj')(path)
      end,
      handlers = {
        ['textDocument/definition'] = require('omnisharp_extended').handler
      }
    }))
  elseif server.name == 'vuels' then
    server:setup(extended_setup({
      init_options = {
        config = {
          vetur = {
            experimental = {
              -- template interpolation doesn't seem to be working with my current Vue 2 project
              templateInterpolationService = false
            }
          }
        }
      }
    }))
  elseif server.name == 'rust_analyzer' then
    require("rust-tools").setup({
      server = vim.tbl_deep_extend('force', server:get_default_options(), {
        on_attach = on_attach_complete
      })
    })
    server:attach_buffers()
  elseif server.name == 'tsserver' then
    server:setup({
      on_attach = function(client)
        on_attach_complete(client)

        local ts_utils = require('nvim-lsp-ts-utils')
        ts_utils.setup{
          debug = false,
          disable_commands = false,
          update_imports_on_move = true,
        }
        ts_utils.setup_client(client)
      end,
      capabilities = lsp_capabilities
    })
  else
    server:setup(complete_lsp_setup)
  end
end)

local nvim_lsp = require('lspconfig')
require('nlua.lsp.nvim').setup(nvim_lsp, complete_lsp_setup)

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
