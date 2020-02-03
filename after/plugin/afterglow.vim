if g:colors_name !=# 'afterglow'
    finish
endif

" Set pmenu to complete black for better Fzf highlighting
hi! Pmenu guibg=#000000
hi! link Conceal Comment

" typescript {{{

hi! link typescriptAliasKeyword Type
hi! link typescriptAccessibilityModifier Type
hi! link typescriptBraces NONE
hi! typescriptParens NONE

" }}}

" vim {{{

hi! link vimUserFunc NONE

" }}}

" NERDTree {{{

hi! link NERDTreeFile NONE

" }}}
