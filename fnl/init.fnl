(local nvim (require :aniseed.nvim))
(local terminal (require :terminal))

(nvim.ex.command_ :-nargs=1 :GTagsContains "Git tag --contains <q-args>")
(nvim.ex.command_ :-nargs=1 :GBranchContains "Git branch --contains <q-args>")

(fn term-shell []
    (if (nvim.fn.has "windows")
        "powershell"
        "zsh"))

(nvim.ex.command_ :Terminal (terminal.CreateCommand "shell" (term-shell)))

nil
