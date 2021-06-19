# Interesting plugins

- nvim-gdb (visual debugger)
- vim-inspector (visual debugger)
- vim-obsession + vim-prosession (session management)
- vim-markdown-composer (markdown live preview)
- ionide-vim (for fsharp)

# TODO

- Only show git indicator when in a git repo in custom `galaxyline` line

# Neovim 0.5 features

## Plugins

- [nvim-dap](https://github.com/mfussenegger/nvim-dap)
  Debug Adapter Protocol client for neovim
- [nvim-lsputils](https://github.com/RishabhRD/nvim-lsputils)
  Some better UI for builtin lsp
- [formatter.nvim](https://github.com/mhartington/formatter.nvim)
  Formatter
- [nvim-treesitter-context](https://github.com/romgrk/nvim-treesitter-context)
  Really nice looking way to show the current context (might be better in status bar though)
- [lspsaga.nvim](https://github.com/glepnir/lspsaga.nvim)
  Interesting plugin for better LSP UIs

### Status bar

- [express_line.nvim](https://github.com/tjdevries/express_line.nvim)
- [galaxyline.nvim](https://github.com/glepnir/galaxyline.nvim)
- [lualine.nvim](https://github.com/hoob3rt/lualine.nvim)

## Current issues/complaints

### nvim-treesitter

- Folds do not get updated until I reload the file with `:e`

### telescope

- Going to a file doesn't enable folds

# Better CS tooling

- Create file with namespace. Could be based on path relative to Solution (or csproj).

## Current issues

- Highlighting is imperfect at best. Support for Semantic tokens is comming which should improve the situation a lot.
- Completion doesn't work well with things that are not imported (not at all or is very slow when enabled).
- Completion doesn't allow for auto imports.
- Completion float only shows 1 implementation and the number of overloads.
- Go to metadata doesn't work yet (doesn't help with completion floats not handled properly).
- Completion's first element sometimes gets highlighted
