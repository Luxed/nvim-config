return {
  showCursorHighlights = function()
    local ft = vim.bo.filetype
    if ft == 'cs' then
      require('omnisharp').show_highlights_under_cursor()
    else
      require('nvim-treesitter-playground.hl-info').show_hl_captures()
    end
  end
}
