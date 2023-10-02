return {
  'lukas-reineke/indent-blankline.nvim',
  config = function()
    -- TODO: This stops the first indent, but only when outside of the first scope.

    --[[ local hooks = require('ibl.hooks')
    hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
    hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_tab_indent_level) ]]

    require('ibl').setup({
      indent = {
        -- TODO: I think having a bold highlight on the current scope might look better

        -- char = { '|', '¦', '┆', '┊' },
      },
      exclude = {
        filetypes = { 'alpha', 'startify', 'fugitive', 'pandoc', 'packer', 'lazy', 'lsp-installer', 'mason', 'mason.nvim', 'markdown' },
        buftypes = { 'terminal', 'help', 'nofile' },
      }
    })
  end
}
