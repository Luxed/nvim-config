" If neovim-gtk is used
if exists('g:GtkGuiLoaded')
    " Ligatures only work on Linux
    call rpcnotify(1, 'Gui', 'Font', 'Fira Code 12')
    call rpcnotify(1, 'Gui', 'Option', 'Tabline', 0)
else
    GuiTabline 0
    GuiPopupmenu 0
    " On windows it is important to install the 'ttf' font
    GuiFont! Fira Code:h12
    "GuiFont! Source Code Pro:h12
endif
