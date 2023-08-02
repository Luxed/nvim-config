-- TODO: Once again I'm having issues with my file explorer. It seems like I've never found something that truly works for me and doesn't break all the time.
-- Here's a new list of requirements:
-- * Can be opened in the current buffer or in a new split. Opening in the "drawer" mode is completely useless to me.
-- * Doesn't override too many keys so I can use the file explorer like a read-only buffer.
-- * Integrates with Git (optional tbh)
-- * Has file icons (pretty important, it really helps me)
-- * Doesn't have to be in Lua. At the end of the day, not everything needs to be in Lua. If that means I go back to Fern or NERDTree, then that's fine. I just want something that works.
-- More info:
-- * I've tried nvim-tree, it's not working like I expect it to.
return {
  'lambdalisue/fern.vim',
  branch = 'main',
  dependencies = {
    'lambdalisue/nerdfont.vim',
    'lambdalisue/glyph-palette.vim',
    'lambdalisue/fern-renderer-nerdfont.vim',
    'lambdalisue/fern-git-status.vim',
    'lambdalisue/fern-hijack.vim',
  },
  init = function()
    vim.g['fern#renderer'] = 'nerdfont'
  end,
  lazy = true,
  cmd = { 'Fern' },
  config = function()
    local glyph_augroup = vim.api.nvim_create_augroup('glyph_palette', {clear = true})
    vim.api.nvim_create_autocmd({'FileType'}, {
      group = glyph_augroup,
      pattern = 'fern',
      callback = function()
        vim.fn['glyph_palette#apply']()
      end,
    })
  end,
  keys = {
    { '<C-f><C-f>', ':Fern . -reveal=% -opener=edit<CR>' },
    { '<C-f>f', ':Fern . -reveal=% -opener=edit<CR>' },
    { '<C-f><C-v>', ':Fern . -reveal=% -opener=vsplit<CR>' },
    { '<C-f>v', ':Fern . -reveal=% -opener=vsplit<CR>' },
    { '<C-f><C-x>', ':Fern . -reveal=% -opener=split<CR>' },
    { '<C-f>x', ':Fern . -reveal=% -opener=split<CR>' },
    { '<C-f><C-h>', ':Fern . -reveal=% -opener=split<CR>' },
    { '<C-f>h', ':Fern . -reveal=% -opener=split<CR>' },
    { '<C-f><C-t>', ':Fern . -reveal=% -opener=tabedit<CR>' },
    { '<C-f>t', ':Fern . -reveal=% -opener=tabedit<CR>' },
  }
}
