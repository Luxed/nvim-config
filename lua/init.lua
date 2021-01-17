--vim.cmd('packloadall')

local nvim_lsp = require('lspconfig')

require'colorizer'.setup {
  dosini = {
    names = false;
    mode = 'background';
  },
  cfg = {
    names = false;
    RRGGBBAA = true;
  }
}

require('nlua.lsp.nvim').setup(require('lspconfig'), {})
nvim_lsp.vuels.setup{}
nvim_lsp.rls.setup{}
nvim_lsp.tsserver.setup{}
nvim_lsp.vimls.setup{}
nvim_lsp.html.setup{}
--nvim_lsp.jdtls.setup{}
nvim_lsp.omnisharp.setup{}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    virtual_text = {
      spacing = 5,
      prefix = ' '
    },
    signs = true,
    update_in_insert = false
  }
)
