# Omnisharp-nvim

## Features

- Semantic highlighting
- Fix usings
- Automatic configuration with [nvim-dap](https://github.com/mfussenegger/nvim-dap)

## Difference with OmniSharp-vim

While [omnisharp-vim](https://github.com/OmniSharp/omnisharp-vim) does support Neovim, it is made in vimscript and does not support Neovim's built-in language server support. Instead it implements its own communication with the OmniSharp server.  
With Omnisharp-nvim, Neovim will be the only supported editor and it will be using the built-in language server support.  

## Requirements and recommentations

- Neovim 0.7+
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
- (Optional) [mason.nvim](https://github.com/williamboman/mason.nvim) and [mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim)
  Those will help you install and manage `omnisharp` and the open-source `netcoredbg` debugger
- (Optional) [omnisharp-extended-lsp.nvim](https://github.com/Hoffs/omnisharp-extended-lsp.nvim)
  Adds metadata support when using the "go to definition" feature
- (Optional) [nvim-lightbulb](https://github.com/kosayoda/nvim-lightbulb)
  Omnisharp has a _lot_ of code actions possible. It is _very_ useful to know when there is at least one availble where the cursor is
- (Optional) [nvim-dap](https://github.com/mfussenegger/nvim-dap) and [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui)
  Required if you want debugging support

## Example configuration

Minimum required:
~~~lua
-- This replaces "require('lspconfig').omnisharp.setup({})"
require('omnisharp').setup({
  -- nvim-lspconfig table here
}, {
  -- omnisharp-nvim configurations here
})
~~~
