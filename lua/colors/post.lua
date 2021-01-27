  -- TODO: find if there's a better way to do this using vim functions
local function hi(group, options)
  local cmd = 'hi! ' .. group .. ' '

  for k,v in pairs(options) do
    cmd = cmd .. k .. '=' .. v .. ' '
  end

  vim.cmd(cmd)
end

local function hi_link(group, link_group)
  vim.cmd('hi! link ' .. group .. ' ' .. link_group)
end

return {
  init = function()
    local colors_name = vim.g.colors_name

    if colors_name == 'ayu' then
      hi_link('csUserIdentifier', 'NONE')
      hi_link('csModifier', 'Structure')

      hi_link('CocHighlightText', 'Visual')

      hi_link('TelescopeMatching', 'Statement')

      -- Add highlight for word under cursor
      hi_link('LspReferenceRead', 'Visual')
      hi('LspDiagnosticsDefaultError', {guifg='#FF3333'})
      hi('LspDiagnosticsUnderlineError', {guifg='#FF3333', gui='underline'})
      hi('LspDiagnosticsUnderlineWarning', {guifg='#FFAE57', gui='underline'})
      hi_link('LspDiagnosticsDefaultWarning', 'Keyword')

      hi('DiffDelete', {guifg='#F28779', guibg='#272D38'})
    elseif colors_name == 'afterglow' then
      -- Set pmenu to complete black for better Fzf highlighting
      hi('Pmenu', {guibg='#000000'})
      hi_link('Conceal', 'Comment')

      -- typescript
      hi_link('typescriptAliasKeyword', 'Type')
      hi_link('typescriptAccessibilityModifier', 'Type')
      hi_link('typescriptBraces', 'NONE')
      hi_link('typescriptParens', 'NONE')

      -- vim
      hi_link('vimUserFunc', 'NONE')

      -- nerdtree
      hi_link('NERDTreeFile', 'NONE')

      hi_link('rustKeyword', 'Type')

      hi_link('LspReferenceRead', 'CursorLine')
      hi_link('LspDiagnosticsDefaultWarning', 'WarningMsg')
      hi('LspDiagnosticsDefaultError', {guifg='#AC4142'})
    elseif colors_name == 'dracula' then
      hi_link('CocErrorSign', 'DraculaRed')
      hi_link('CocErrorFloat', 'DraculaRed')
      hi_link('CocErrorHighlight', 'DraculaErrorLine')

      hi_link('CocWarningSign', 'DraculaOrange')
      hi_link('CocWarningFloat', 'DraculaOrange')
      hi_link('CocWarningHighlight', 'DraculaWarnLine')

      hi_link('Conceal', 'Comment')
      hi_link('fugitiveHash', 'DraculaCyan')

      hi_link('LspReferenceRead', 'CursorLine')
    elseif colors_name == 'nord' then
      hi_link('Conceal', 'Comment')
      hi_link('Folded', 'Comment')

      hi('DiffAdd', {guibg='NONE', gui='NONE'})
      hi('DiffDelete', {guibg='NONE', gui='NONE'})

      hi_link('fugitiveHash', 'Type')
      -- typescript (yats)

      -- blue
      hi_link('typescriptImport', 'Keyword')
      hi_link('typescriptExport', 'Keyword')
      hi_link('typescriptVariable', 'Type')
      hi_link('typescriptOperator', 'Type')
      hi_link('typescriptAssign', 'Type')
      hi_link('typescriptBinaryOp', 'Type')
      hi_link('typescriptTypeAnnotation', 'Type')

      hi('typescriptClassName', {guifg='#8FBCBB'})
      hi('typescriptTypeReference', {guifg='#8FBCBB'})
      hi('typescriptPredefinedType', {guifg='#8FBCBB'})
      hi('typescriptArrayMethod', {guifg='#8FBCBB'})
      hi('typescriptGlobal', {guifg='#8FBCBB'})
      hi('typescriptHeadersMethod', {guifg='#8FBCBB'})
      hi('typescriptArrayMethod', {guifg='#8FBCBB'})
      hi('typescriptDecorator', {guifg='#D08770'})

      -- Clearing
      hi_link('typescriptBraces', 'NONE')
      hi_link('typescriptParens', 'NONE')
      hi_link('typescriptMember', 'NONE')
      hi_link('typescriptCall', 'NONE')
      hi_link('typescriptObjectLabel', 'NONE')
    end

    require('nvim-web-devicons').setup()
  end
}
