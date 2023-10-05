return {
  'lukas-reineke/indent-blankline.nvim',
  dependencies = {
    {
      'rainbow-delimiters',
      url = 'https://gitlab.com/HiPhish/rainbow-delimiters.nvim',
      init = function()
        vim.g.rainbow_delimiters = {
          highlight = {
            'RainbowDelimiter1',
            'RainbowDelimiter2',
            'RainbowDelimiter3',
            'RainbowDelimiter4',
          },
        }
      end,
    },
  },
  config = function()
    -- TODO: This stops the first indent, but only when outside of the first scope.

    --[[ local hooks = require('ibl.hooks')
    hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
    hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_tab_indent_level) ]]

    require('ibl').setup({
      indent = {
        char = { '|', '¦', '┆', '┊' },
      },
      exclude = {
        filetypes = { 'alpha', 'startify', 'fugitive', 'pandoc', 'packer', 'lazy', 'lsp-installer', 'mason', 'mason.nvim', 'markdown' },
        buftypes = { 'terminal', 'help', 'nofile' },
      },
      scope = {
        enabled = true,
        show_start = true,
        show_end = true,
        -- highlight = { "Delimiter" },
        -- Using this works, but changing theme to something that doesn't have those highlights will cause issues
        highlight = { 'RainbowDelimiter1', 'RainbowDelimiter2', 'RainbowDelimiter3', 'RainbowDelimiter4', },
      },
    })
  end
}
