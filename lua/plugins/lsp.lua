vim.diagnostic.config({
  float = {
    border = 'rounded'
  }
})

local function on_attach_complete(client, bufnr)
  require('commands').lsp()
  require('keymaps').lsp(client)

  require('nvim-navic').attach(client, bufnr)

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
        border = 'rounded'
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
  border = "rounded"
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signatureHelp, {
  border = "rounded"
})

local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
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
      require('omnisharp').setup{
        solution_first = true,
        automatic_dap_configuration = true,
        highlight = {
          enabled = true,
          groups = {
            -- Custom
            -- TODO: Put custom colors into ayu-vim directly
            OmniSharpEnumName = {fg = '#91b6ff'},
            OmniSharpInterfaceName = {fg = '#70e6d2'},
            OmniSharpStructName = {fg = '#6ae693'},
            OmniSharpTypeParameterName = {fg = '#aabbee'}, -- NOTE: This is a cool color that fits very well within the ayu color palette. Could be a bit "brighter" maybe.
            OmniSharpPreprocessorKeyword = {fg = vim.fn['ayu#get_color']('extended_fg_idle')},
            OmniSharpPropertyName = {link = 'TSProperty'},
            OmniSharpFieldName = {link = 'TSField'},
            OmniSharpParameterName = {link = 'TSParameter'},
            OmniSharpVerbatimStringLiteral = {fg = vim.fn['ayu#get_color']('syntax_regexp')},
            OmniSharpLocalName = {link = 'Normal'},
          }
        },
        server = extended_setup({
          handlers = {
            ['textDocument/definition'] = require('omnisharp_extended').handler
          }
        })
      }
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
      local mason_path = vim.fn.stdpath('data') .. '/mason'
      local extension_path = mason_path .. '/packages/codelldb/extension'
      local codelldb_path = extension_path .. '/adapter/codelldb'
      local liblldb_path = extension_path .. '/lldb/lib/liblldb.so'
      local codelldb_adapter = require('rust-tools.dap').get_codelldb_adapter(codelldb_path, liblldb_path)

      require("rust-tools").setup({
        tools = {
          inlay_hints = {
            only_current_line = true,
            highlight = 'DiagnosticVirtualTextHint',
          }
        },
        -- hover_with_actions = true,
        server = {
          on_attach = on_attach_complete,
          standalone = false,
        },
        dap = {
          adapter = codelldb_adapter
        },
      })
    elseif server_name == 'tsserver' then
      lspconfig[server_name].setup({
        on_attach = function(client, bufnr)
          on_attach_complete(client, bufnr)

          local ts_utils = require('nvim-lsp-ts-utils')
          ts_utils.setup{
            debug = false,
            disable_commands = false,
            update_imports_on_move = true,
          }
          ts_utils.setup_client(client)
        end,
        capabilities = lsp_capabilities,
        root_dir = require('lspconfig.util').root_pattern('package.json', 'tsconfig.json', 'jsconfig.json')
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
    elseif server_name == 'denols' then
      lspconfig[server_name].setup(extended_setup({
        root_dir = require('lspconfig.util').root_pattern('deno.json', 'deno.jsonc')
      }))
    elseif server_name == 'volar' then
      local function get_typescript_lib_path(root_dir)
        local util = require('lspconfig.util')
        local project_root = util.find_node_modules_ancestor(root_dir)
        return util.path.join(project_root, 'node_modules', 'typescript', 'lib')
      end

      lspconfig[server_name].setup(extended_setup({
        init_options = {
          typescript = {
            tsdk = '',
          }
        },
        on_new_config = function(new_config, new_root_dir)
          new_config.init_options.typescript.tsdk = get_typescript_lib_path(new_root_dir)
        end
      }))
    else
      lspconfig[server_name].setup(complete_lsp_setup)
    end
  end
}

vim.fn.sign_define('DiagnosticSignError'           , { text='' })
vim.fn.sign_define('DiagnosticSignWarn'            , { text='' })
vim.fn.sign_define('DiagnosticSignInfo'            , { text='' })
vim.fn.sign_define('DiagnosticSignHint'            , { text='ﯦ' })
vim.fn.sign_define('LspDiagnosticsSignError'       , { text='' })
vim.fn.sign_define('LspDiagnosticsSignWarning'     , { text='' })
vim.fn.sign_define('LspDiagnosticsSignInformation' , { text='' })
vim.fn.sign_define('LspDiagnosticsSignHint'        , { text='ﯦ' })
vim.fn.sign_define('LightBulbSign'                 , { text='' })
