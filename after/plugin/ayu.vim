if get(g:, 'colors_name', '') !=# 'ayu'
    finish
endif

hi! link csUserIdentifier NONE
hi! link csModifier Structure

hi! link CocHighlightText Visual

hi! link TelescopeMatching Statement

" Add highlight for word under cursor
hi! link LspReferenceRead Visual
hi! LspDiagnosticsDefaultError guifg=#FF3333
hi! link LspDiagnosticsDefaultWarning WarningMsg
" only underline errors
hi! LspDiagnosticsUnderlineError gui=underline

" TODO: Move this into Lua config. It should be globally set
sign define LspDiagnosticsSignError text=
sign define LspDiagnosticsSignWarning text=
sign define LspDiagnosticsSignInformation text=
sign define LspDiagnosticsSignHint text=ﯦ
