# Interesting plugins

- nvim-gdb (visual debugger)
- vim-inspector (visual debugger)
- vim-obsession + vim-prosession (session management)
- vim-markdown-composer (markdown live preview)
- ionide-vim (for fsharp)
- [nvim-dap](https://github.com/mfussenegger/nvim-dap)
  Debug Adapter Protocol client for neovim
- [formatter.nvim](https://github.com/mhartington/formatter.nvim)
  Formatter

## Status bars

- [express_line.nvim](https://github.com/tjdevries/express_line.nvim)
- [galaxyline.nvim](https://github.com/glepnir/galaxyline.nvim)
- [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)

# TODO

- ~~Only show git indicator when in a git repo in custom `galaxyline` line~~
  Either update to a maintained version of Galaxyline or change status line
- Move all keybinds in a single location
- Disable virtual text for hints

# Better CS tooling

- Create file with namespace. Could be based on path relative to Solution (or csproj)
  (csproj or solution file needs to be read for a Namespace too, maybe the LSP would have something for this?)
  See [here](https://github.com/jchannon/csharpextensions) and [here](https://github.com/KreativJos/csharpextensions) (newer version).
- Go to metadata.
  See [here](https://github.com/OmniSharp/omnisharp-vim/blob/master/autoload/OmniSharp/actions/definition.vim).
- Completion float multiple implementations (hover). Handle overloaded methods.
  See [here](https://github.com/OmniSharp/omnisharp-vim).

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
  - `:` and `??` are not highlighted
  - In `new Type()`, "Type" should be highlighted as constructor
  - `where T : EntityBase`, "EntityBase" is not highlighted, it should be "type"
