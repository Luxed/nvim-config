# Personnal Neovim configuration files

## Bindings

The bindings present here are given in the same order as the files

### Vanilla

| Bindings            | Mode     | Use                                 |
|---------------------|----------|-------------------------------------|
| ,                   | Any      | \<leader\> key                      |
| \<leader\>n         | Terminal | Exit Terminal                       |
| \<leader\>n         | Normal   | Remove current highlight            |
| \<leader\>T         | Normal   | New empty buffer                    |
| \<leader\>l         | Normal   | Next buffer                         |
| \<leader\>h         | Normal   | Previous buffer                     |
| \<leader\>bq        | Normal   | Quit current buffer                 |
| \<leader\>bl        | Normal   | List Buffers                        |
| \<leader\>wq        | Normal   | Quit current buffer and window      |
| zS                  | Normal   | Echo syntax of element under cursor |
| \<Space\>           | Normal   | za (toggle fold)                    |
| \<leader\>\<Space\> | Normal   | zc (close fold)                     |
| \<leader\>zj        | Normal   | Go to the next fold                 |
| \<leader\>zk        | Normal   | Go to the previous fold             |

### Plugins

#### General

| Bindings         | Mode   | Use                                       |
|------------------|--------|-------------------------------------------|
| Plugin: ALE      |
| \<leader\>an     | Normal | Ale next wrap (next error, warning, etc.) |
| \<leader\>ap     | Normal | Ale previous wrap                         |
| \<leader\>ah     | Normal | Ale hover                                 |
| \<leader\>ag     | Normal | Ale go to definition                      |
| Plugin: NERDTree |
| \<C-N\>          | Any    | NERDTree toggle                           |
| Plugin: CtrlP    |
| \<leader\>pp     | Normal | Launch CtrlP                              |
| \<leader\>pb     | Normal | Launch CtrlP in buffer mode               |
| \<leader\>pm     | Normal | Launch CtrlP in mixed mode                |
| \<leader\>ps     | Normal | Launch CtrlP in MRU mode                  |
| Plugin: Tagbar   |
| \<C-T\>          | Normal | Tagbar toggle                             |

#### FileType

| Bindings       | Mode   | Use                                         |
|----------------|--------|---------------------------------------------|
| FileType: Help |
| \<CR\>         | Normal | \<C-]\> (go to the definition under cursor) |
| \<BS\>         | Normal | \<C-T\> (go back to where you were before)  |

## Commands

A list of the custom commands I made.

| Command | Use                                                                      |
|---------|--------------------------------------------------------------------------|
| H       | Opens the help in a split above (because default behavior is splitbelow) |

## How it works

The first file executed is the `init.vim` file.
1) This file executes the `~/.config/nvim/00_vanilla.vim` file.
    - This file contains every setting and keymap that doesn't require a plugin to work.
2) Then it executes the `~/.config/nvim/01_plugins.vim` file.
    - This file contains every plugin to load with `vim-plug`.
3) Then it executes the `~/.config/nvim/02_pluginsConf.vim` file.
    - This file contains every configuration and keymap for every plugin (the order and categories are the same as `01_plugins.vim`).
4) Then it puts the correct colorscheme and defines some theme/interface options.
