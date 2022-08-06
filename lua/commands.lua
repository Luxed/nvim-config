return {
  vanilla = function()
    vim.api.nvim_create_user_command('Rmhl', ':let @/=""', {})
    vim.api.nvim_create_user_command('DeleteHiddenBuffers', 'call buffers#delete_all_hidden()', {})
  end,
  lsp = function()
    vim.api.nvim_buf_create_user_command(0, 'Format', function()
      vim.lsp.buf.format({async = true})
    end, {})
  end,
}
