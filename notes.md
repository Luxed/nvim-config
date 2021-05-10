# Interesting plugins

- nvim-gdb (visual debugger)
- vim-inspector (visual debugger)
- vim-open-color
- vim-obsession + vim-prosession (session management)
- vim-markdown-composer (markdown live preview)
- ionide-vim (for fsharp)

# TODO

- Only show git indicator when in a git repo in custom `galaxyline` line
- Make real "dropdown" theme for Telescope based on current cursor position. (useful for quick actions like LSP Code Actions)

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

### built-in lsp

- Find a way to remove annoying quickfix list being automatically shown on "go to definition"

### telescope

- Going to a file doesn't enable folds

