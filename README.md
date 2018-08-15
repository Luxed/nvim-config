# Personnal Neovim configuration files

## Bindings

### Vanilla

| Bindings            | Mode     | Use                                 |
|---------------------|----------|-------------------------------------|
| ,                   | Any      | Leader key                          |
| \<leader\>n         | Terminal | Exit Terminal                       |
| \<leader\>n         | Normal   | Remove current highlight            |
| \<leader\>T         | Normal   | New empty buffer                    |
| \<leader\>l         | Normal   | Next buffer                         |
| \<leader\>h         | Normal   | Previous buffer                     |
| \<leader\>bq        | Normal   | Quit current buffer                 |
| \<leader\>bl        | Normal   | List Buffers                        |
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
