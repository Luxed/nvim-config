vim.cmd [[packloadall]]

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

-- vuels: `npm install -g vls`
require'nvim_lsp'.vuels.setup{}
-- rls: `rustup component add rust-src rust-analysis rls`
require'nvim_lsp'.rls.setup{}
-- tsserver: `npm install -g typescript-language-server`
require'nvim_lsp'.tsserver.setup{}
-- vimls: `npm install -g vim-language-server`
require'nvim_lsp'.vimls.setup{}
