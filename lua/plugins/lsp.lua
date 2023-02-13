vim.diagnostic.config({
  float = {
    border = 'rounded'
  }
})

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

vim.fn.sign_define('DiagnosticSignError', { text = '' })
vim.fn.sign_define('DiagnosticSignWarn', { text = '' })
vim.fn.sign_define('DiagnosticSignInfo', { text = '' })
vim.fn.sign_define('DiagnosticSignHint', { text = 'ﯦ' })
vim.fn.sign_define('LspDiagnosticsSignError', { text = '' })
vim.fn.sign_define('LspDiagnosticsSignWarning', { text = '' })
vim.fn.sign_define('LspDiagnosticsSignInformation', { text = '' })
vim.fn.sign_define('LspDiagnosticsSignHint', { text = 'ﯦ' })
vim.fn.sign_define('LightBulbSign', { text = '' })

local function lsp_config(server_name)
  local complete_lsp_setup = {
    on_attach = function(client, bufnr)
      require('commands').lsp()
      require('keymaps').lsp(client)

      if client.server_capabilities.documentSymbolProvider then
        require('nvim-navic').attach(client, bufnr)
      end

      require('nvim-lightbulb').setup({
        autocmd = {
          enabled = true
        },
        float = {
          enabled = false
        }
      })

      -- In "Vue" files, everything is defined in a function, so it's very annoying to get the popup all the time
      if vim.bo.filetype ~= 'vue' then
        require('lsp_signature').on_attach({
          bind = true,
          hint_prefix = '',
          hi_parameter = 'IncSearch',
          handler_opts = {
            border = 'rounded'
          }
        })
      end
    end,
    capabilities = vim.tbl_deep_extend(
      'force',
      vim.lsp.protocol.make_client_capabilities(),
      require('cmp_nvim_lsp').default_capabilities()
    )
  }

  local function extended_setup(additional_options)
    additional_options = additional_options or {}

    return vim.tbl_extend('force', complete_lsp_setup, additional_options)
  end

  local lspconfig = require('lspconfig')
  if server_name == 'omnisharp' or server_name == 'omnisharp_mono' then
    lspconfig[server_name].setup(
      require('omnisharp').setup {
        solution_first = true,
        automatic_dap_configuration = true,
        highlight = {
          enabled = true,
          fixSemanticTokens = true,
          groups = {
            OmniSharpEnumName              = { link = '@enum' },
            OmniSharpInterfaceName         = { link = '@interface' },
            OmniSharpStructName            = { link = '@struct' },
            OmniSharpTypeParameterName     = { link = '@typeParameter' },
            OmniSharpPreprocessorKeyword   = { fg = vim.fn['ayu#get_color']('extended_fg_idle') },
            OmniSharpPropertyName          = { link = '@property' },
            OmniSharpFieldName             = { link = '@field' },
            OmniSharpParameterName         = { link = '@parameter' },
            OmniSharpVerbatimStringLiteral = { fg = vim.fn['ayu#get_color']('syntax_regexp') },
            OmniSharpLocalName             = { fg = vim.fn['ayu#get_color']('editor_fg') }
          },
        },
        is_mono = server_name == 'omnisharp_mono',
        server = extended_setup({
          handlers = {
            ['textDocument/definition'] = require('omnisharp_extended').handler
          }
        })
      }
    )
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
        on_attach = complete_lsp_setup.on_attach,
        standalone = false,
      },
      dap = {
        adapter = codelldb_adapter
      },
    })
  elseif server_name == 'tsserver' then
    lspconfig[server_name].setup({
      on_attach = function(client, bufnr)
        complete_lsp_setup.on_attach(client, bufnr)

        local ts_utils = require('nvim-lsp-ts-utils')
        ts_utils.setup {
          debug = false,
          disable_commands = false,
          update_imports_on_move = true,
        }
        ts_utils.setup_client(client)
      end,
      capabilities = complete_lsp_setup.capabilities,
      root_dir = require('lspconfig.util').root_pattern('package.json', 'tsconfig.json', 'jsconfig.json')
    })
  elseif server_name == 'lua_ls' then
    -- TODO: Only set these settings when inside of a neovim related directory (I.E. ~/.config/nvim or ~/.local/share/nvim)
    lspconfig[server_name].setup(extended_setup({
      settings = {
        Lua = {
          runtime = {
            version = 'LuaJIT',
          },
          diagnostics = {
            globals = { 'vim' }
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
  else
    lspconfig[server_name].setup(complete_lsp_setup)
  end
end

return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'Hoffs/omnisharp-extended-lsp.nvim',
    'Luxed/omnisharp-nvim',
    'kosayoda/nvim-lightbulb',
    'simrat39/rust-tools.nvim',
    'ray-x/lsp_signature.nvim',
    'jose-elias-alvarez/nvim-lsp-ts-utils',
    {
      'j-hui/fidget.nvim',
      config = function()
        require('fidget').setup({})
      end
    },
    'SmiteshP/nvim-navic',

    -- LSP installer
    {
      'williamboman/mason.nvim',
      config = function()
        require('mason').setup({
          ui = {
            border = 'rounded'
          }
        })
      end
    },
    {
      'williamboman/mason-lspconfig.nvim',
      config = function()
        require('mason-lspconfig').setup({
          ensure_installed = {}
        })
      end
    }
  },
  config = function()
    require('mason-lspconfig').setup_handlers({ lsp_config })
  end,
}
