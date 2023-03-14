local function hi(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end
local function hi_link(group, link_group)
  vim.api.nvim_set_hl(0, group, {link=link_group})
end

return {
  init = function()
    local colors_name = vim.g.colors_name

    local extend_colors_dict = {
      ['ayu'] = function()
        local ayu_hi = vim.fn['ayu#hi']
        -- TODO CB: Move relevant things to theme directly
        ayu_hi('PreProc', 'extended_fg_idle', '')
        ayu_hi('Include', 'extended_namespace', '', 'bold')
        
        -- Green checkmark, red when not checked
        ayu_hi('@text.todo.checked.markdown', 'vcs_added', '')
        ayu_hi('@text.todo.unchecked.markdown', 'vcs_removed', '')

        hi_link('@storageclass', 'Keyword')
        hi_link('@builtinType', '@type.builtin')

        hi_link('@lsp.type.namespace', '@namespace')
        hi_link('@lsp.type.class', '@class')
        hi_link('@lsp.type.interface', '@interface')
        hi_link('@lsp.type.enum', '@enum')
        hi_link('@lsp.type.typeParameter', '@typeParameter')
        hi_link('@lsp.type.parameter', '@parameter')
        hi_link('@lsp.type.struct', '@struct')
        hi_link('@lsp.type.variable', '@variable')
      end,
      ['afterglow'] = function()
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
      end,
      ['dracula'] = function()
        hi_link('CocErrorSign', 'DraculaRed')
        hi_link('CocErrorFloat', 'DraculaRed')
        hi_link('CocErrorHighlight', 'DraculaErrorLine')

        hi_link('CocWarningSign', 'DraculaOrange')
        hi_link('CocWarningFloat', 'DraculaOrange')
        hi_link('CocWarningHighlight', 'DraculaWarnLine')

        hi_link('Conceal', 'Comment')
        hi_link('fugitiveHash', 'DraculaCyan')

        hi_link('LspReferenceRead', 'CursorLine')
      end,
      ['nord'] = function()
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
    }

    local extend_colors = extend_colors_dict[colors_name]
    if extend_colors ~= nil then
      extend_colors()
    end

    require('nvim-web-devicons').setup()
  end
}
