" If neovim-gtk is used
if exists('g:GtkGuiLoaded')
    " Font with ligatures
    call rpcnotify(1, 'Gui', 'Font', 'Fira Code 12')
    call rpcnotify(1, 'Gui', 'Option', 'Tabline', 0)
else
    GuiTabline 0
    GuiPopupmenu 0
endif
