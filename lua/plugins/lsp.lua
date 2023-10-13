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

local complete_lsp_setup = {
  on_attach = function(client, bufnr)
    require('commands').lsp()
    require('keymaps').lsp(client)

    if client.server_capabilities.documentSymbolProvider then
      require('nvim-navic').attach(client, bufnr)
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

local function lsp_config(server_name)
  local lspconfig = require('lspconfig')
  if server_name == 'omnisharp' or server_name == 'omnisharp_mono' then
    lspconfig[server_name].setup(
      require('omnisharp').setup {
        solution_first = true,
        automatic_dap_configuration = true,
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
    lspconfig[server_name].setup(extended_setup({
      root_dir = require('lspconfig.util').root_pattern('package.json', 'tsconfig.json', 'jsconfig.json')
    }))
  elseif server_name == 'lua_ls' then
    lspconfig[server_name].setup(extended_setup({
      settings = {
        Lua = {
          completion = {
            callSnippet = "Replace"
          },
          hint = { enable = true }
        }
      }
    }))
  elseif server_name == 'denols' then
    lspconfig[server_name].setup(extended_setup({
      root_dir = require('lspconfig.util').root_pattern('deno.json', 'deno.jsonc')
    }))
  elseif server_name == 'gopls' then
    -- Do nothing, let the go plugin take care of everything
  elseif server_name == 'volar' then
    lspconfig[server_name].setup(extended_setup({
      filetypes = {'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue'},
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
    {
      'kosayoda/nvim-lightbulb',
      event = 'LspAttach',
      config = function()
        require('nvim-lightbulb').setup({
          autocmd = {
            enabled = true
          },
          float = {
            enabled = false
          }
        })
      end
    },
    'simrat39/rust-tools.nvim',
    {
      'ray-x/go.nvim',
      dependencies = {
        'ray-x/guihua.lua',
      },
      config = function()
        require('go').setup({
          dap_debug_keymap = false, -- They never get removed from the buffer, super annoying
          run_in_floaterm = true,
          floaterm = {
            posititon = 'right',
            width = 0.45,
            height = 0.5, -- height doesn't work with right
          },
          lsp_inlay_hints = {
            enable = true
          },
          lsp_cfg = extended_setup(),
        })
      end,
      event = { 'CmdLineEnter' },
      ft = { 'go', 'gomod' },
      -- build = ':lua require("go.install").update_all_sync()'
    },
    {
      'folke/neodev.nvim',
      config = function()
        require('neodev').setup({})
      end
    },
    {
      'ray-x/lsp_signature.nvim',
      event = 'LspAttach',
      config = function()
        -- In "Vue" files, everything is defined in a function, so it's very annoying to get the popup all the time
        if vim.bo.filetype ~= 'vue' then
          require('lsp_signature').on_attach({
            bind = true,
            hint_enable = false,
            hint_prefix = '',
            hint_inline = function() return false end,
            hi_parameter = 'IncSearch',
            handler_opts = {
              border = 'rounded'
            }
          })
        end
      end
    },
    {
      'j-hui/fidget.nvim',
      -- TODO: Switch off from the "legacy" branch?
      branch = 'legacy',
      event = 'LspAttach',
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
          ensure_installed = { 'lua_ls', 'jsonls', 'vimls' }
        })
      end
    }
  },
  config = function()
    require('mason-lspconfig').setup_handlers({ lsp_config })
  end,
}
