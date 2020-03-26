if get(g:, 'colors_name', '') !=# 'dracula' || dracula#should_abort()
    finish
endif

if exists('g:coc_enabled')
    hi! link CocErrorSign DraculaRed
    hi! link CocErrorFloat DraculaRed
    hi! link CocErrorHighlight DraculaErrorLine

    hi! link CocWarningSign DraculaOrange
    hi! link CocWarningFloat DraculaOrange
    hi! link CocWarningHighlight DraculaWarnLine
endif

hi! link Conceal Comment
hi! link fugitiveHash DraculaCyan
