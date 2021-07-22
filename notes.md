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

- Create file with namespace. Could be based on path relative to Solution (or csproj) (csproj or solution file needs to be read for a Namespace too, maybe the LSP would have something for this?)

## Current issues

- Highlighting is imperfect at best. Support for Semantic tokens is comming which should improve the situation a lot.
- Completion doesn't work well with things that are not imported (not at all or is very slow when enabled).
- Completion doesn't allow for auto imports.
- Completion float only shows 1 implementation and the number of overloads.
  Instead of showing documentation it could show every implementation maybe?
- Go to metadata doesn't work yet (doesn't help with completion floats not handled properly).

## Create omnisharp-nvim

- OmniSharpFixUsings: Remove unused using directives
  (in file `usings.vim`)

# Treesitter issues

## CSharp

- ~~Named arguments not highlighted~~
- ~~`nameof` not highlighted like `typeof` (operator)~~
- ~~`out` keyword is not detected~~
- ~~type after `out` keyword is not highlighted~~
- ~~highlight tuple definition (locals)~~
- highlight `base` as Constructor?
- Type parameter constraint clause needs to be idented
- Things like `Where(a =>\n{\n\treturn true;\n});` does not get indented as I would expect (but it still makes sense)
- ~~Add support for LinQ query syntax~~
- ~~`in` in linq query should be a "keyword", not a "repeat" (maybe it could be a keyword everywhere?)~~
- Indentation does not work properly on binary expressions
- `this` keyword on extension methods not highlighted
- One line "ifs" are not indented properly
- ~~function with generic (without `this.`) gets highlighted as a Type~~
- Single line methods indentation
