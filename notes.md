# Interesting plugins

- nvim-gdb (visual debugger)
- vim-inspector (visual debugger)
- vim-open-color
- vim-obsession + vim-prosession (session management)
- vim-markdown-composer (markdown live preview)

# TODO

- Look into `netrw` (built in file explorer) to potentially replace NERDTree (only used for quick look at project or sometimes "project drawer" style which doesn't fit Vim very well)
- Make interface to create Lua mappings without needing to use strings
  Buffer bound keys might be more difficult to handle (this might grow too big and slow down, or it won't because it's dynamic, so it should be fine)
- Change colors of statusline
- Make `nvim-bufferline.lua` reloadable
- Make `galaxyline.nvim` change colors when vim mode changes
- Only show git indicator when in a git repo

# Neovim 0.5 features

## Plugins

- [nvim-dap](https://github.com/mfussenegger/nvim-dap)
  Debug Adapter Protocol client for neovim
- [nvim-lsputils](https://github.com/RishabhRD/nvim-lsputils)
  Some better UI for builtin lsp
- [nvim-autopairs](https://github.com/windwp/nvim-autopairs)
  Maybe a working autopair plugin
- [formatter.nvim](https://github.com/mhartington/formatter.nvim)
  Formatter
- [nvim-treesitter-context](https://github.com/romgrk/nvim-treesitter-context)
  Really nice looking way to show the current context (might be better in status bar though)

### Status bar

- [express_line.nvim](https://github.com/tjdevries/express_line.nvim)
- [galaxyline.nvim](https://github.com/glepnir/galaxyline.nvim)
- [lualine.nvim](https://github.com/hoob3rt/lualine.nvim)

- [lsp-status.nvim](https://github.com/nvim-lua/lsp-status.nvim)
  Helper functions

## Current issues/complaints

### nvim-treesitter

- ~~Doesn't update properly when doing some actions and needs to be completely refreshed~~
  Didn't notice the issue anymore, might be fixed.
- Highlighting doesn't look all that good on all themes out of the box
- `nvim-ts-rainbow` performs extremely poorly and makes Neovim feel like Visual Studio

### completion-nvim

- Orders things weirdly (maybe setting the sorting to "none" would resolve this issue?)
- Flickers when using "fuzzy" matching strategy (not a deal breaker, but it makes it look much less polished than other completion plugins)
- Chain completion just isn't my thing (maybe)
- (most likely Neovim related issue) Documentation popup sometimes gets collapsed by my folds configuration ("syntax" globally + folded by default)
  Folding would need to be disabled globally and setup for every filetypes I want

### built-in lsp

- Find a way to remove annoying quickfix list being automatically shown on "go to definition"
