setlocal foldmethod=expr
setlocal foldexpr=nvim_treesitter#foldexpr()

setlocal foldlevel=2

command -buffer DotnetDebug lua require('omnisharp').launch_debug()
