vim.cmd('packloadall')

local nvim_lsp = require('nvim_lsp')

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
nvim_lsp.vuels.setup{
  on_attach = require'diagnostic'.on_attach
}
-- rls: `rustup component add rust-src rust-analysis rls`
nvim_lsp.rls.setup{
  on_attach = require'diagnostic'.on_attach
}
-- tsserver: `npm install -g typescript-language-server`
nvim_lsp.tsserver.setup{
  on_attach = require'diagnostic'.on_attach
}
-- vimls: `npm install -g vim-language-server`
nvim_lsp.vimls.setup{
  on_attach = require'diagnostic'.on_attach
}
-- html language server: LspInstall html
nvim_lsp.html.setup{}
-- java language server: LspInstall jdtls
--nvim_lsp.jdtls.setup{}
-- lua-language-server: LspInstall sumneko_lua
nvim_lsp.omnisharp.setup{}
--[[nvim_lsp.sumneko_lua.setup{
    cmd = {
        "/home/cbrunel/.cache/nvim/nvim_lsp/sumneko_lua/lua-language-server/bin/Linux/lua-language-server",
        "-E",
        "/home/cbrunel/.cache/nvim/nvim_lsp/sumneko_lua/lua-language-server/main.lua"
    },
    [>runtime = {
        path = {
            "?.lua",
            "?/init.lua",
            "?/?.lua",
            "~/git/neovim/runtime/lua/?.lua",
            "~/git/neovim/runtime/lua/?/?.lua",
            "~/git/neovim/src/nvim/lua/?.lua"
        },
    },<]
    on_attach = require'diagnostic'.on_attach
}]]
require('nlua.lsp.nvim').setup(nvim_lsp, {
        on_attach = require('diagnostic').on_attach,
})

--[[require'nvim-treesitter.configs'.setup {
    ensure_installed = { "typescript" },
    highlight = {
        enable = true
    },
    refactor = {
        highlight_definitions = {
            enable = true
        }
    }
}]]

--[[local telescope_theme = require('telescope.themes').get_dropdown {
    previewer = nil
}]]

--[[require('telescope').setup{
    defaults = {
        sorting_strategy = "ascending",
        layout_strategy = "center",
        borderchars = {
            prompt = {"─", "│", " ", "│", "╭", "╮", "│", "│"},
            results = {"─", "│", "─", "│", "├", "┤", "╯", "╰"},
            preview = {"─", "│", "─", "│", "╭", "╮", "┤", "├"}
        }
    }
}]]
