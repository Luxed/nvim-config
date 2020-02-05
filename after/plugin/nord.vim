if g:colors_name !=# 'nord'
    finish
endif

hi! link Conceal Comment
hi! link Folded Comment

hi! DiffAdd guibg=NONE gui=NONE
hi! DiffDelete guibg=NONE gui=NONE

hi! link fugitiveHash StorageClass
