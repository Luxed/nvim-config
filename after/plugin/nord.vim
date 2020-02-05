if g:colors_name !=# 'nord'
    finish
endif

hi! link Conceal Comment
hi! link Folded Comment

hi! DiffAdd guibg=NONE gui=NONE
hi! DiffDelete guibg=NONE gui=NONE

hi! link fugitiveHash Type

" typescript (yats) {{{

" blue
hi! link typescriptImport Keyword
hi! link typescriptExport Keyword
hi! link typescriptVariable Type
hi! link typescriptOperator Type
hi! link typescriptAssign Type
hi! link typescriptBinaryOp Type
hi! link typescriptTypeAnnotation Type

" green
hi! typescriptClassName guifg=#8FBCBB
hi! typescriptTypeReference guifg=#8FBCBB
hi! typescriptPredefinedType guifg=#8FBCBB
hi! typescriptArrayMethod guifg=#8FBCBB
hi! typescriptGlobal guifg=#8FBCBB
hi! typescriptHeadersMethod guifg=#8FBCBB
hi! typescriptArrayMethod guifg=#8FBCBB
" red
hi! typescriptDecorator guifg=#D08770

" Clearing
hi! link typescriptBraces NONE
hi! link typescriptParens NONE
hi! link typescriptMember NONE
hi! link typescriptCall NONE
hi! link typescriptObjectLabel NONE

" }}}
