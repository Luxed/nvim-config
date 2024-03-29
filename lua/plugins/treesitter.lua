---@diagnostic disable: missing-fields
return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
    'nvim-treesitter/playground',
    'windwp/nvim-ts-autotag',
    'm-demare/hlargs.nvim',
  },
  config = function()
    local enabled = {
      'bash',
      'c_sharp', 'css',
      'dockerfile',
      'fish',
      'go',
      'html',
      'javascript', 'jsdoc', 'json',
      'lua',
      'markdown', 'markdown_inline',
      'nix',
      'python',
      'query',
      'rust',
      'scss',
      'typescript', 'tsx',
      'vim', 'vue',
      'yaml'
    }

    require('nvim-treesitter.configs').setup({
      ensure_installed = enabled,
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
        disable = {
          'css',
          'fish',
          'go',
          'html',
          'javascript', 'jsdoc',
          'lua',
          'markdown', 'markdown_inline',
          'nix',
          'python',
          'rust',
          'vim',
          'yaml'
        }
      },
      playground = {
        enable = true,
      },
      textobjects = {
        select = {
          enable = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            ["ia"] = "@parameter.inner",
            ["aa"] = "@parameter.outer",
          }
        }
      },
      autotag = {
        enable = true
      }
    })

    require('hlargs').setup({})
  end
}
