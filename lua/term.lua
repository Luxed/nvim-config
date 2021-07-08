local term_id = 0

return {
  open = function()
    local new_term = false
    if term_id == 0 or (not vim.api.nvim_buf_is_loaded(term_id)) then
      term_id = vim.api.nvim_create_buf(false, false)
      new_term = true
    end

    vim.api.nvim_set_current_buf(term_id)

    if new_term then
      vim.cmd('command! -buffer Fg :b#')
      vim.fn.termopen('powershell')
    end
  end,
}
