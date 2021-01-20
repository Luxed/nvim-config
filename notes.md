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
- Look into `netrw` (built in file explorer) to potentially replace NERDTree (only used for quick look at project or sometimes "project drawer" style which doesn't fit Vim very well)
- Make interface to create Lua mappings without needing to use strings
- Fix error message when Language server doesn't implement `textDocument/documentHighlight`

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

### nvim-treesitter

- Doesn't update properly when doing some actions and needs to be completely refreshed
- Highlighting doesn't look all that good on all themes out of the box

### completion-nvim

- Orders things weirdly (maybe setting the sorting to "none" would resolve this issue?)
- Flickers when using "fuzzy" matching strategy (not a deal breaker, but it makes it look much less polished than other completion plugins)
- Relative paths aren't supported
- Chain completion just isn't my thing (maybe)
- Using `vim-vsnip` fixed this issue
- (most likely Neovim related issue) Documentation popup sometimes gets collapsed by my folds configuration ("syntax" globally + folded by default)

### omnisharp-vim

- Features only work with ALE for linting (no support for integration with builtin lsp), doesn't work with `completion-nvim`, doesn't work with `telescope.nvim`

### built-in LSP

- Missing colors for errors, Warnins, etc.
- Missing underline for error.
