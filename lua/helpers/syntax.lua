return {
  showCursorHighlights = function()
    if vim.fn.has('nvim-0.9') == 1 then
      vim.show_pos()
    else
      local ft = vim.bo.filetype
      if ft == 'cs' then
        require('omnisharp').show_highlights_under_cursor()
      else
        require('nvim-treesitter-playground.hl-info').show_hl_captures()
      end
    end
  end
}
