local cmp = require('cmp')

cmp.setup{
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    --['<CR>'] = cmp.mapping.confirm({
        --behavior = cmp.ConfirmBehavior.Insert,
        --select = false,
      --}),
  },

  sources = {
    {
      name = 'buffer',
      opts = {
        get_bufnrs = function()
          local bufs = {}
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            bufs[vim.api.nvim_win_get_buf(win)] = true
          end
          return vim.tbl_keys(bufs)
        end
      },
    },
    { name = 'path' },
    { name = 'nvim_lsp' },
    { name = 'vsnip' }
  }
}
