local lsp_status = require('lsp-status')

local function on_attach_complete(client)
  -- NOTE: Some lsp (like omnisharp for example) will _crash_ instead of doing nothing when asked for highlight
  if client.server_capabilities['documentHighlightProvider'] then
    local bufnr = vim.fn.bufnr()
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

  require('commands').lsp()
  require('keymaps').lsp(client)

  lsp_status.on_attach(client)

  require('nvim-lightbulb').setup({
    autocmd = {
      enabled = true
    },
    float = {
      enabled = false
    }
  })

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
      require('omnisharp').setup(complete_lsp_setup)
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
      -- TODO: Make sure the debugger only gets attached if it is installed
      local mason_path = vim.fn.stdpath('data') .. '/mason'
      local extension_path = mason_path .. '/packages/codelldb/extension'
      local codelldb_path = extension_path .. '/adapter/codelldb'
      local liblldb_path = extension_path .. '/lldb/lib/liblldb.so'
      local codelldb_adapter = require('rust-tools.dap').get_codelldb_adapter(codelldb_path, liblldb_path)

      require("rust-tools").setup({
        hover_with_actions = true,
        server = {
          on_attach = on_attach_complete
        },
        dap = {
          adapter = codelldb_adapter
        },
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
    elseif server_name == 'sumneko_lua' then
      lspconfig[server_name].setup(extended_setup({
        settings = {
          Lua = {
            runtime = {
              version = 'LuaJIT',
            },
            diagnostics = {
              globals = {'vim'}
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file('', true),
            },
            telemetry = {
              enable = false,
            }
          },
        }
      }))
    else
      lspconfig[server_name].setup(complete_lsp_setup)
    end
  end
}

local nvim_lsp = require('lspconfig')
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
