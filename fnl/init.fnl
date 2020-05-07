(local nvim (require :aniseed.nvim))
(local terminal (require :terminal))

;(let [mapping (require :aniseed.mapping)]
  ;(mapping.init))

(nvim.ex.command_ :-nargs=1 :GTagsContains "Git tag --contains <q-args>")
(nvim.ex.command_ :-nargs=1 :GBranchContains "Git branch --contains <q-args>")

(fn term-shell []
    (if (nvim.fn.has "windows")
        "cmd"
        "zsh"))

(nvim.ex.command_ :Terminal (terminal.CreateCommand "shell" (term-shell)))
(nvim.ex.command_ :Fennel (terminal.CreateCommand "fennel" "fennel"))

nil
