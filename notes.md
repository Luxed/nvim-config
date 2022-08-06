# Interesting plugins

- nvim-gdb (visual debugger)
- vim-inspector (visual debugger)
- [nvim-dap](https://github.com/mfussenegger/nvim-dap)
  Debug Adapter Protocol client for neovim
- [formatter.nvim](https://github.com/mhartington/formatter.nvim)
  Formatter
- [spellsitter.nvim](https://github.com/lewis6991/spellsitter.nvim)
  Only check for spelling mistakes in comments
- [nvim-code-action-menu](https://github.com/weilbith/nvim-code-action-menu)
  Shows not only the available code actions but also their effect in a handy diff float.

# TODO

- Look into [nvim-notify](https://github.com/rcarriga/nvim-notify), a very nice looking notification plugin. Would be one more step towards Neovim being not only a good editor, but also a good OS
- Look into [nvim-navic](https://github.com/SmiteshP/nvim-navic) as a replacement to `lsp-status.nvim` which seems to be currently unmaintained
- `:h foldminlines` & `:h foldnestmax`

# Better CS tooling

- Create file with namespace. Could be based on path relative to Solution (or csproj)
  (csproj or solution file needs to be read for a Namespace too, maybe the LSP would have something for this?)
  See [here](https://github.com/jchannon/csharpextensions) and [here](https://github.com/KreativJos/csharpextensions) (newer version).
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
