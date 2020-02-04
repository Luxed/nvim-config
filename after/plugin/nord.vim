if g:colors_name !=# 'nord'
    finish
endif

hi! link Conceal Comment
hi! link Folded Comment

hi! DiffAdd guibg=NONE gui=NONE
hi! DiffDelete guibg=NONE gui=NONE

hi! link fugitiveHash Type

hi! link typescriptImport Keyword
hi! link typescriptExport Keyword
hi! link typescriptBraces NONE
hi! link typescriptParens NONE
hi! typescriptClassName guifg=#8FBCBB
hi! typescriptTypeReference guifg=#8FBCBB
hi! link typescriptMember NONE
hi! typescriptDecorator guifg=#D08770
