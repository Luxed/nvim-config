vim.cmd('packloadall')

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

nvim_lsp.vuels.setup{
  on_attach = require'diagnostic'.on_attach
}
nvim_lsp.rls.setup{
  on_attach = require'diagnostic'.on_attach
}
nvim_lsp.tsserver.setup{
  on_attach = require'diagnostic'.on_attach
}
nvim_lsp.vimls.setup{
  on_attach = require'diagnostic'.on_attach
}
nvim_lsp.html.setup{}
--nvim_lsp.jdtls.setup{}
nvim_lsp.omnisharp.setup{}
require('nlua.lsp.nvim').setup(nvim_lsp, {
        on_attach = require('diagnostic').on_attach,
})
