setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
let &l:breakat = ' (=*-+;,/'

setlocal foldmethod=expr
setlocal foldexpr=nvim_treesitter#foldexpr()
