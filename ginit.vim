" If neovim-gtk is used
if exists('g:GtkGuiLoaded')
    " Ligatures only work on Linux
    call rpcnotify(1, 'Gui', 'Font', 'FuraCode NF 11')
    call rpcnotify(1, 'Gui', 'Option', 'Tabline', 0)
else
    GuiTabline 0
    GuiPopupmenu 0
    " On windows it is important to install the 'ttf' font
    "GuiFont! Fira Code:h11
    "GuiFont! Source Code Pro Medium:h11
    GuiFont! FuraCode NF:h11
    "GuiFont! Hasklug NF:h11
    "GuiFont! DejaVuSansMono NF:h11
endif
