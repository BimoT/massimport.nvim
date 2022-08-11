# massimport.nvim

A neovim plugin to simplify writing import statements

Written in Lua, for Neovim. Instead of having to write `local thing = require("thing")` for seven different libraries, you can now do this a lot faster. If your language of choice is not supported, please let me know so that I can implement that.

![Command mode gif](https://raw.githubusercontent.com/BimoT/massimport.nvim/main/.assets/commandmode.gif)

## Features

This plugin provides the following:

- Command `:Massimport`, which takes arguments and turns them into import statements.
- Normal mode massimport function: splits the current line by whitespace and turns every word into a separate import statement.
- Visual mode massimport function: turns each line in the visual selection into a separate import statement.

For a demonstration, see the .gif files in the .assets folder.
For the normal mode and visual mode, you need a proper configuration (see [below](#Configuring)).


## Requirements

This plugin uses [plenary.nvim](https://github.com/nvim-lua/plenary.nvim/) for testing and filetype detection.

## Installing

You can install it using your package manager, like [vim-plug](https://github.com/junegunn/vim-plug) or [Packer.nvim](https://github.com/wbthomason/packer.nvim).

```lua
-- Using Plug:
Plug 'bimot/massimport.nvim'

-- Using packer:
use { "bimot/massimport.nvim" }
```

## Configuring

Currently, there are only two options for configuration: `normalmode_keys` and `visualmode_keys`.


```lua
-- default values for the setup:
require("massimport").setup({
        normalmode_keys = "<leader>m", -- keys for the normal mode
        visualmode_keys = "<leader>m", -- keys for in visual mode
})
```

If you omit the setup function, then you will only have access to the `:Massimport` command. If you set one of the values to an empty string, then the setup function will not map that key. This will also let you set the keymaps yourself, using something like [whichkey](https://github.com/folke/which-key.nvim).

In that case, the two things that you need to bind are:
- `"<cmd>lua require('massimport.core').massimport_normalmode()<cr>"` for the normal mode functionality
- `"<cmd>lua require('massimport.core').massimport_visualmode()<cr>"` for the visual mode functionality

## Future changes:

TODO: better filetype detection (integration with LSP or treesitter perhaps?)

TODO: maybe also handle different import styles, such as in python: `from pandas import DataFrame` or `import numpy as np`

TODO: add dot-repeatability
