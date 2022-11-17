# Things to check or do

## Plugins

### Git plugins

- [neogit](https://github.com/TimUntersberger/neogit)
  Fugitive replacement? (I don't really have any issues with Fugitive though. Maybe I should just learn to use it before maybe)
- [vgit.nvim](https://github.com/tanvirtin/vgit.nvim). Looks interesting
- [diffview.nvim](https://github.com/sindrets/diffview.nvim).
  Interesting looking merge tool and other visual git tools.

### LSP related plugins

- [nvim-code-action-menu](https://github.com/weilbith/nvim-code-action-menu)
  Shows not only the available code actions but also their effect in a handy diff float.
  NOTE: Finally got around to testing this and am I not even surprised that it doesn't work with Omnisharp...
  But it _does_ work with csharp-language-server.
  Now that I think about it, it's possible that the OmniSharp server has an endpoint under "o#/v2" or just "o#"
  NOTE: I searched for it. Didn't find anything conclusive. I don't even know if that's a feature in VSCode? I know it is in Visual Studio, but that might not even come from an endpoint.
  _Maybe_ a diff could be made with the current buffer and a new temporary buffer with the code action applied? Is that even possible or does it directly change the current buffer?
- [lua-dev.nvim](https://github.com/folke/lua-dev.nvim)
  Could replace nlua.nvim which seems unmaintained?
- [sqls.nvim](https://github.com/nanotee/sqls.nvim)
  Language server for SQL in Neovim
  NOTES: Took the time to try it. It works, which is already a good thing, but it's missing a lot of things to be usable.
  Completion is very lacking for MSSQL (for example I couldn't get any results when search for a user defined table valued function, EXEC is not a keyword, functions are not recognized, etc.).
  The treesitter syntax is also very incomplete for MSSQL.
- [document-color.nvim](https://github.com/mrshmllow/document-color.nvim)
  Colorizer for LSP colors specifically.
- [lsp-inlayhints.nvim](https://github.com/lvimuser/lsp-inlayhints.nvim).
  When the "anti conceal" feature of Neovim will be merged, this will be a good plugin to have for some language (especially things like Typescript, Rust, or even sometimes C#)

### Other

- [nvim-spectre](https://github.com/nvim-pack/nvim-spectre)
  An alternative to CtrlsF (which I've never really taken the time to learn and use properly. Last time I checked it also had issues with Neovim)
- [refactoring.nvim](https://github.com/ThePrimeagen/refactoring.nvim)
  Refactoring library
- [other.nvim](https://github.com/rgroli/other.nvim)
  Better than my "switcher" thing?
- [nvim-ufo](https://github.com/kevinhwang91/nvim-ufo)
  Better & faster folds.
  NOTES: Tried it. Looks amazing. Exactly what I want. _But_. It's buggy and doesn't behave nearly the same as with normal folds. Will be worth checking again later (just like how indent-blankline was unusable until it got to the point where it did exactly what I needed it to do)
- [exrc.nvim](https://github.com/MunifTanjim/exrc.nvim)
  Per project config in lua
- [vim-sleuth](https://github.com/tpope/vim-sleuth)
  Detect file indentation automatically
- [LuaSnip](https://github.com/L3MON4D3/LuaSnip)
  Full Lua replacement for vsnip.
- [snippet-converter.nvim](https://github.com/smjonas/snippet-converter.nvim). Convert between snippet formats.
- [recipe.nvim](https://github.com/ten3roberts/recipe.nvim)
  Load workspace local "recipes" (similar to vscode "tasks").
- [nvim-hlslens](https://github.com/kevinhwang91/nvim-hlslens)
  Improve "*" and "#" motions
- [persistent-breakpoints.nvim](https://github.com/Weissle/persistent-breakpoints.nvim)
  Keep breakpoints after closing and reopening neovim.
- [colortils.nvim](https://github.com/nvim-colortils/colortils.nvim). Color utilities.
- `:h foldminlines` & `:h foldnestmax`

# OmniSharp-nvim plugin ideas/wishlist

These ideas mostly come from the OmniSharp-vim plugin

- Create file with namespace. Could be based on path relative to Solution (or csproj)
  (csproj or solution file needs to be read for a Namespace too, maybe the LSP would have something for this?)
  See [here](https://github.com/jchannon/csharpextensions) and [here](https://github.com/KreativJos/csharpextensions) (newer version).
  Maybe it would be a good idea to have advanced snippets using something like LuaSnip? Maybe we could have snippets that can create everything.
- Completion float multiple implementations (hover). Handle overloaded methods.
  See [here](https://github.com/OmniSharp/omnisharp-vim).
  This already kind of works thanks to the signature plugin.
- Run unit tests and navigate to failing assertions
- Ability to use dotnet or mono version. Could be also great if csharp_ls could also be used.
  It would be even better if the choice of language server could be made by project.
  Especially since csharp_ls should be good enough for simple projects while omnisharp would be better for more complex projects and the mono version would be great to work on anything .NET Framework related.
- Ability to show diagnostic id
  This is possible when using `o#/codecheck`.
  So it would have to be integrated into the current diagnostics somehow.
- Ability to exclude files/paths from diagnostics

## Additional information

- The `o#/project` and `o#/projects` endpoints have some interesting and useful information about the current project and workspace respectively

## Done or started

- Semantic highlighting [when this PR is merged](https://github.com/neovim/neovim/pull/15723) (I swear it will happen one day, or not...)
  Tried to request `textDocument/semanticTokens/full` handler and it is marked as "not implemented" even though omnisharp-vim has it??? Is this some kind of custom thing again??
  Of course it's custom. Why would it use the specification that they made themselves?? Instead you'll need to use the `o#/v2/highlight` request.
- Debugging using `netcoredbg` (cause, you know, vsdbg, the "working" debugger is still closed source. So much for going "open source")
- For some time, the lsp highlight provider for the current symbol under the cursor didn't work with Omnisharp, is this still the case? If yes, would it be possible to implement it using the `o#` endpoints?
  Seems like it works using [vim-illuminate](https://github.com/RRethy/vim-illuminate).

## Won't do

- ~~Support for multiple completion engines (as long as the engine supports Neovim's built-in LSP, this should not be a problem)~~
  This shouldn't have to be implemented by this plugin.
- ~~Loading status for status line and/or notification (similar to the "progress" endpoint?). Found in [vim-sharpenup](https://github.com/nickspoons/vim-sharpenup#statusline)~~
  Turns out this looks pretty much custom with how OmniSharp-vim internally works
- Fix using statements (sort, remove and add missing)
  This can be done using the format option that fixes the usings.

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
