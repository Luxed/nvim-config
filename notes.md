# Things to check or do

- [spellsitter.nvim](https://github.com/lewis6991/spellsitter.nvim)
  Only check for spelling mistakes in comments
- [nvim-code-action-menu](https://github.com/weilbith/nvim-code-action-menu)
  Shows not only the available code actions but also their effect in a handy diff float.
  NOTE: Finally got around to testing this and am I not even surprised that it doesn't work with Omnisharp...
  But it _does_ work with csharp-language-server.
- [nvim-spectre](https://github.com/nvim-pack/nvim-spectre)
  An alternative to CtrlsF (which I've never really taken the time to learn and use properly. Last time I checked it also had issues with Neovim)
- [refactoring.nvim](https://github.com/ThePrimeagen/refactoring.nvim)
  Refactoring library
- [cmp-dap](https://github.com/rcarriga/cmp-dap)
  Completion for dap repl and dap ui watches
- [other.nvim](https://github.com/rgroli/other.nvim)
  Better than my "switcher" thing?
- [lua-dev.nvim](https://github.com/folke/lua-dev.nvim)
  Could replace nlua.nvim which seems unmaintained?
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
