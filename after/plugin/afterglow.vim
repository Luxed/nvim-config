if g:colors_name !=# 'afterglow'
    finish
endif

" Set pmenu to complete black for better Fzf highlighting
hi! Pmenu guibg=#000000
hi! link Conceal Comment

hi! link typescriptAliasKeyword Type
hi! link typescriptAccessibilityModifier Type
hi! link typescriptBraces Normal
hi! typescriptBraces guibg=NONE guifg=#d6d6d6
hi! typescriptParens guibg=NONE guifg=#d6d6d6
