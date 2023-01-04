return {
  {
    'antoinemadec/FixCursorHold.nvim',
    config = function()
      vim.g.cursorhold_updatetime = 100
    end
  },
  {
    'folke/todo-comments.nvim',
    config = function()
      require('todo-comments').setup()
    end
  },
  {
    'RRethy/vim-illuminate',
    config = function()
      require('illuminate').configure({
        providers = {
          'lsp',
          'treesitter',
          -- 'regex' -- Currently disabled, but might be useful in some cases
        },
        delay = 100,
        under_cursor = false, -- Highlight any word under the cursor
      })
    end
  },
}
