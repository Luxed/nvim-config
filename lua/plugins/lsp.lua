local lsp_status = require('lsp-status')

local function on_attach_keymaps()
  local buf_command = require('helpers.command').buf_command
  buf_command('Format', 'lua vim.lsp.buf.formatting()')

  require('keymaps').lsp()
end

local function on_attach_complete(client)
  local bufnr = vim.fn.bufnr()

  -- NOTE: Some lsp (like omnisharp for example) will _crash_ instead of doing nothing when asked for highlight
  if client.server_capabilities['documentHighlightProvider'] then
    local highlight_augroup = vim.api.nvim_create_augroup('lsp_document_highlight_' .. tostring(bufnr), {clear = true})
    vim.api.nvim_create_autocmd('CursorHold', {
      group = highlight_augroup,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.document_highlight()
      end
    })
    vim.api.nvim_create_autocmd('CursorMoved', {
      group = highlight_augroup,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.clear_references()
      end
    })
  end

  require('nvim-lightbulb').setup({
    autocmd = {
      enabled = true
    },
    float = {
      enabled = false
    }
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

require('mason').setup()
require('mason-lspconfig').setup{
  ensure_installed = {'rust_analyzer', 'omnisharp', 'tsserver'}
}

require('mason-lspconfig').setup_handlers{
  function (server_name)
    local lspconfig = require('lspconfig')
    if server_name == 'omnisharp' then
      lspconfig[server_name].setup(extended_setup({
        root_dir = function(path)
          local root_pattern = require('lspconfig.util').root_pattern
          -- Make sure an sln doesn't already exist before trying to use the nearest csproj file
          return root_pattern('*.sln')(path) or root_pattern('*.csproj')(path)
        end,
        handlers = {
          ['textDocument/definition'] = require('omnisharp_extended').handler
        }
      }))
    elseif server_name == 'vuels' then
      lspconfig[server_name].setup(extended_setup({
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
    elseif server_name == 'rust_analyzer' then
      require("rust-tools").setup({
        server = {
          on_attach = on_attach_complete
        }
      })
    elseif server_name == 'tsserver' then
      lspconfig[server_name].setup({
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
      lspconfig[server_name].setup(complete_lsp_setup)
    end
  end
}

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
