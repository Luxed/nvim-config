# Personnal Neovim configuration files

## Install

First, install the plugin manager used for my configs (dein.vim):

### Linux

`git clone https://github.com/Shougo/dein.vim ~/.config/nvim/dein/repos/github.com/Shougo/dein.vim`

### Windows

`git clone https://github.com/Shougo/dein.vim $HOME\AppData\Local\nvim\dein\repos\github.com\Shougo\dein.vim`

Then you need to launch neovim and install the plugins by running `:call dein#install()`.

Once this is done some plugins may need to be registered to python, for this, make sure you python are correctly detected.
You can follow [this](https://github.com/deoplete-plugins/deoplete-jedi/wiki/Setting-up-Python-for-Neovim) tutorial if you are not sure on how to setup your python 2.7 and 3.7 installs.

After python is correctly installed for Neovim, run the `:UpdateRemotePlugins` command.

You can now restart neovim and everything should be working correctly

## Fonts

To have the best possible experience with this config files, you will need a [NerdFont](https://nerdfonts.com) patched font.
By default I use `Fira Code` because I really like it, but there are a lot of patched fonts that are really great.
Beware that fonts like `Fira Code` have a registered name and are renamed when installed with NerdFont. `Fira Code` becomes `FuraCode NF`.

### On Linux

Either download it from their site and put it in your fonts user directory or use your package manager to install them.

### On Windows

I highly recommend to use [scoop](https://scoop.sh) and the [scoop-nerd-fonts bucket](https://github.com/matthewjberger/scoop-nerd-fonts) to install the fonts properly and without any issue.
To search for all the possible fonts simply do `scoop search "-NF"`.

## Bindings

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
| \<leader\>ww        | Normal   | Save current buffer                 |
| \<leader\>ei        | Normal   | Edit init.vim file                  |
| \<leader\>si        | Normal   | Source init.vim file                |
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
| \<leader\>ar     | Normal | Ale find references                       |
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
| Rmhl    | Clears the search register                                               |

## How it works

The first file executed is the `init.vim` file.
1) This file executes the `~/.config/nvim/00_vanilla.vim` file.
    - This file contains every setting and keymap that doesn't require a plugin to work.
2) Then it executes the `~/.config/nvim/01_plugins.vim` file.
    - This file contains every plugin to load with `vim-plug`.
3) Then it executes the `~/.config/nvim/02_pluginsConf.vim` file.
    - This file contains every configuration and keymap for every plugin (the order and categories are the same as `01_plugins.vim`).
4) Then it puts the correct colorscheme and defines some theme/interface options.

Another important file if you want to run a GUI like `nvim-qt` or `nvim-gtk` is `ginit.vim`.
In this file are declared the configurations needed for Fonts and other GUI specific things.
