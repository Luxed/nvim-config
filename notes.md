# Interesting plugins

- nvim-gdb (visual debugger)
- vim-inspector (visual debugger)
- vim-obsession + vim-prosession (session management)
- vim-markdown-composer (markdown live preview)
- ionide-vim (for fsharp)

# TODO

- Only show git indicator when in a git repo in custom `galaxyline` line
- Move all keybinds in a single location
- Disable virtual text for hints

# Neovim 0.5 features

## Plugins

- [nvim-dap](https://github.com/mfussenegger/nvim-dap)
  Debug Adapter Protocol client for neovim
- [formatter.nvim](https://github.com/mhartington/formatter.nvim)
  Formatter

### Status bar

- [express_line.nvim](https://github.com/tjdevries/express_line.nvim)
- [galaxyline.nvim](https://github.com/glepnir/galaxyline.nvim)
- [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)

## Current issues/complaints

### telescope

- Going to a file doesn't enable folds

# Better CS tooling

- Create file with namespace. Could be based on path relative to Solution (or csproj) (csproj or solution file needs to be read for a Namespace too, maybe the LSP would have something for this?)

## Current issues

- Highlighting is imperfect at best. Support for Semantic tokens is comming which should improve the situation a lot.
- Completion float only shows 1 implementation and the number of overloads.
  Instead of showing documentation it could show every implementation maybe?
  The way OmniSharp-vim does it is to have 1 completion item per implementation.
  While VSCode gives you 1 completion item for all, but then the popup can be scrolled through using the arrow keys to find the implementation/documentation of the override you want.
- Go to metadata doesn't work yet (doesn't help with completion floats not handled properly).

# Treesitter issues

## CSharp

### Current

- Indentation:
  - Type parameter constraint clause needs to be idented
  - Things like `Where(a =>\n{\n\treturn true;\n});` does not get indented as I would expect (but it still makes sense)
    The correct fix for this would be to always have the brackets always be ignored for identation? Maybe like the comments?
  - Indentation does not work properly on binary expressions
  - One line "ifs" are not indented properly
  - Single line methods indentation
- Highlighting:
  - is expression not highlighting type
  - catch's "when" keyword not highlighted
  - maybe "default" should be highlighted as a "keyword operator" instead of a "keyword"
