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

require'nvim_lsp'.rls.setup{}
