# Personnal Neovim configuration files

## Install

First, install the plugin manager used for my configs (dein.vim):

### Linux

`git clone https://github.com/Shougo/dein.vim ~/.config/nvim/dein/repos/github.com/Shougo/dein.vim`

### Windows

`git clone https://github.com/Shougo/dein.vim $HOME\AppData\Local\nvim\dein\repos\github.com\Shougo\dein.vim`

### Both

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
