# Interesting plugins

- nvim-gdb (visual debugger)
- vim-inspector (visual debugger)
- vim-open-color
- vim-obsession + vim-prosession (session management)
- vim-markdown-composer (markdown live preview)
- vim-packager (possible replacement to minpac)
- [packer.nvim](https://github.com/wbthomason/packer.nvim)
  Lua replacement for minpac

# TODO

- ~~Move some plugin configurations to own files (in autoload or in new directory with dynamic loading)~~
- Move entire config to Lua

# Neovim 0.5 features

## Plugins

- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
  Better syntax highlighting where possible.
  This one will need a lot more work since not all colorshemes are compatible. `nightfly` seems to be the only supported theme that I currently have.
- [nvim-dap](https://github.com/mfussenegger/nvim-dap)
  Debug Adapter Protocol client for neovim
- [nvim-jdtls](https://github.com/mfussenegger/nvim-jdtls)
  Better Java language server support
- [nvim-lsputils](https://github.com/RishabhRD/nvim-lsputils)
  Some better UI for builtin lsp
- [nvim-autopairs](https://github.com/windwp/nvim-autopairs)
  Maybe a working autopair plugin
- [formatter.nvim](https://github.com/mhartington/formatter.nvim)
  Formatter

### Status bar

- [express_line.nvim](https://github.com/tjdevries/express_line.nvim)
- [galaxyline.nvim](https://github.com/glepnir/galaxyline.nvim)
- [lualine.nvim](https://github.com/hoob3rt/lualine.nvim)
- [lsp-status.nvim](https://github.com/nvim-lua/lsp-status.nvim)
  Helper functions

## Current issues/complaints

- `nvim-treesitter` doesn't update properly when doing some actions and needs to be completely refreshed
- `nvim-treesitter` highlighting doesn't look all that good on all themes out of the box
- `completion-nvim` orders things weirdly (maybe setting the sorting to "none" would resolve this issue?)
- `completion-nvim` flickers when using "fuzzy" matching strategy (not a deal breaker, but it makes it look much less polished than other completion plugins)
- `completion-nvim` relative paths aren't supported
- `completion-nvim` chain completion just isn't my thing
- `completion-nvim` support for Java and Omnisharp isn't optimal (completing `Console.WriteLi|<c-n>` for example will write `Console.WriteLine();|`. When parameters are available, their information will be written)
- `diagnostic-nvim` "NextDiagnostic" and "NextDiagnoticCycle" don't always work (even when there are visible diagnostics)
- `omnisharp-vim` features only work with ALE for linting (no support for integration with builtin lsp), doesn't work with `completion-nvim`, doesn't work with `telescope.nvim`
- `telescope.nvim` works but still feels rough around the edges sometimes
