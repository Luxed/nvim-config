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
