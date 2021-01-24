local nvim_lsp = require('lspconfig')
local au = require('helpers.command').autocmd
local map = require('helpers.map')
local lsp_status = require('lsp-status')

local function on_attach_au(client)
  if client.resolved_capabilities.document_highlight then
    au('CursorHold',  '<buffer>', 'lua vim.lsp.buf.document_highlight()')
    au('CursorHoldI', '<buffer>', 'lua vim.lsp.buf.document_highlight()')
    au('CursorMoved', '<buffer>', 'lua vim.lsp.buf.clear_references()')
  end
end

-- TODO use buffer number from LSP to bind keys
local function on_attach_keymaps()
  local silent_opts = {silent = true}
  map.nnore('<leader>qk', '<cmd>lua vim.lsp.buf.hover()<CR>', silent_opts, true)
  map.nnore('K', '<cmd>lua vim.lsp.buf.hover()<CR>', silent_opts, true)
  map.nnore('<leader>qK', '<cmd>lua vim.lsp.buf.signature_help()<CR>', silent_opts, true)
  map.nnore('<leader>qq', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', silent_opts, true)
  --map.nnore('<leader>qgr', '<cmd>lua vim.lsp.buf.references()<CR>', silent_opts, true)
  map.nnore('<leader>qgd', '<cmd>lua vim.lsp.buf.definition()<CR>', silent_opts, true)
  map.nnore('<leader>qgi', '<cmd>lua vim.lsp.buf.implementation()<CR>', silent_opts, true)
  map.nnore('<leader>qr', '<cmd>lua vim.lsp.buf.rename()<CR>', {}, true)
  --map.nnore('<leader>qa', '<cmd>lua vim.lsp.buf.code_action()<CR>', {}, true)
  map.nnore('<leader>qn', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', {}, true)
  map.nnore('<leader>qp', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', {}, true)
  map.nnore('<leader>qd', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', {}, true)

  -- use Telescope for more convenient and consistent UI
  map.nnore('<leader>qgr', '<cmd>lua require("telescope.builtin").lsp_references()<CR>', {}, true)
  map.nnore('<leader>qa', '<cmd>lua require("telescope.builtin").lsp_code_actions()<CR>', {}, true)
  map.nnore('<leader>qs', '<cmd>lua require("telescope.builtin").lsp_document_symbols()<CR>', {}, true)

  -- override default keymap
  vim.api.nvim_buf_set_keymap(0, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', {})
end

local function on_attach_complete(client)
  on_attach_au(client)
  on_attach_keymaps()

  lsp_status.on_attach(client)
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

local complete_lsp_setup = {
  on_attach = on_attach_complete,
  capabilities = lsp_status.capabilities
}

nvim_lsp.vuels.setup(complete_lsp_setup)
nvim_lsp.rls.setup(complete_lsp_setup)
nvim_lsp.tsserver.setup(complete_lsp_setup)
nvim_lsp.vimls.setup(complete_lsp_setup)
nvim_lsp.html.setup(complete_lsp_setup)
--nvim_lsp.jdtls.setup(complete_lsp_setup)
require('nlua.lsp.nvim').setup(nvim_lsp, complete_lsp_setup)

-- TODO: make this work for Linux and Windows
local pid = vim.fn.getpid()
local home = vim.fn.expand('~')
local omnisharp_bin = home .. '/.local/opt/omnisharp-server/run'
nvim_lsp.omnisharp.setup{
  cmd = { omnisharp_bin, '--languageserver', '--hostPID', tostring(pid) },
  on_attach = on_attach_complete
}

vim.fn.sign_define('LspDiagnosticsSignError', { text = '' })
vim.fn.sign_define('LspDiagnosticsSignWarning', { text='' })
vim.fn.sign_define('LspDiagnosticsSignInformation', { text='' })
vim.fn.sign_define('LspDiagnosticsSignHint', { text='ﯦ' })
