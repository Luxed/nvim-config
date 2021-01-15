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

- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
  Better syntax highlighting where possible.
  This one will need a lot more work since not all colorshemes are compatible. `nightfly` seems to be the only supported theme that I currently have.
- [nvim-dap](https://github.com/mfussenegger/nvim-dap)
  Debug Adapter Protocol client for neovim
