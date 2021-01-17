return {
  getCursorHighlights = function()
    local synstack = vim.fn.synstack(vim.fn.line('.'), vim.fn.col('.'))
    local map = vim.fn.map(synstack, 'synIDattr(v:val, "name")')
    return vim.fn.join(vim.fn.reverse(map), ' ')
  end
}
