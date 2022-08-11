local classification_type_names = {
  { name = 'Comment'                            , highlight = 'OmniSharpComment'         , desc = 'comment'}                                  ,
  { name = 'ExcludedCode'                       , highlight = 0                          , desc = 'excluded code'}                            ,
  { name = 'Identifier'                         , highlight = 'OmniSharpIdentifier'      , desc = 'identifier'}                               ,
  { name = 'Keyword'                            , highlight = 'OmniSharpKeyword'         , desc = 'keyword'}                                  ,
  { name = 'ControlKeyword'                     , highlight = 'OmniSharpControlKeyword'  , desc = 'keyword - control'}                        ,
  { name = 'NumericLiteral'                     , highlight = 'OmniSharpNumericLiteral'  , desc = 'number'}                                   ,
  { name = 'Operator'                           , highlight = 'OmniSharpOperator'        , desc = 'operator'}                                 ,
  { name = 'OperatorOverloaded'                 , highlight = 0                          , desc = 'operator - overloaded'}                    ,
  { name = 'PreprocessorKeyword'                , highlight = 0                          , desc = 'preprocessor keyword'}                     ,
  { name = 'StringLiteral'                      , highlight = 'OmniSharpStringLiteral'   , desc = 'string'}                                   ,
  { name = 'WhiteSpace'                         , highlight = 0                          , desc = 'whitespace'}                               ,
  { name = 'Text'                               , highlight = 'OmniSharpText'            , desc = 'text'}                                     ,
  { name = 'StaticSymbol'                       , highlight = 0                          , desc = 'static symbol'}                            ,
  { name = 'PreprocessorText'                   , highlight = 0                          , desc = 'preprocessor text'}                        ,
  { name = 'Punctuation'                        , highlight = 0                          , desc = 'punctuation'}                              ,
  { name = 'VerbatimStringLiteral'              , highlight = 0                          , desc = 'string - verbatim'}                        ,
  { name = 'StringEscapeCharacter'              , highlight = 0                          , desc = 'string - escape character'}                ,
  { name = 'ClassName'                          , highlight = 'OmniSharpClass'           , desc = 'class name'}                               ,
  { name = 'DelegateName'                       , highlight = 0                          , desc = 'delegate name'}                            ,
  { name = 'EnumName'                           , highlight = 'OmniSharpEnum'            , desc = 'enum name'}                                ,
  { name = 'InterfaceName'                      , highlight = 'OmniSharpInterface'       , desc = 'interface name'}                           ,
  { name = 'ModuleName'                         , highlight = 0                          , desc = 'module name'}                              ,
  { name = 'StructName'                         , highlight = 'OmniSharpStruct'          , desc = 'struct name'}                              ,
  { name = 'TypeParameterName'                  , highlight = 'OmniSharpTypeParameter'   , desc = 'type parameter name'}                      ,
  { name = 'FieldName'                          , highlight = 'OmniSharpField'           , desc = 'field name'}                               ,
  { name = 'EnumMemberName'                     , highlight = 0                          , desc = 'enum member name'}                         ,
  { name = 'ConstantName'                       , highlight = 'OmniSharpConstant'        , desc = 'constant name'}                            ,
  { name = 'LocalName'                          , highlight = 0                          , desc = 'local name'}                               ,
  { name = 'ParameterName'                      , highlight = 0                          , desc = 'parameter name'}                           ,
  { name = 'MethodName'                         , highlight = 'OmniSharpMethod'          , desc = 'method name'}                              ,
  { name = 'ExtensionMethodName'                , highlight = 'OmniSharpExtensionMethod' , desc = 'extension method name'}                    ,
  { name = 'PropertyName'                       , highlight = 'OmniSharpField'           , desc = 'property name'}                            ,
  { name = 'EventName'                          , highlight = 0                          , desc = 'event name'}                               ,
  { name = 'NamespaceName'                      , highlight = 'OmniSharpNamespace'       , desc = 'namespace name'}                           ,
  { name = 'LabelName'                          , highlight = 0                          , desc = 'label name'}                               ,
  { name = 'XmlDocCommentAttributeName'         , highlight = 0                          , desc = 'xml doc comment - attribute name'}         ,
  { name = 'XmlDocCommentAttributeQuotes'       , highlight = 0                          , desc = 'xml doc comment - attribute quotes'}       ,
  { name = 'XmlDocCommentAttributeValue'        , highlight = 0                          , desc = 'xml doc comment - attribute value'}        ,
  { name = 'XmlDocCommentCDataSection'          , highlight = 0                          , desc = 'xml doc comment - cdata section'}          ,
  { name = 'XmlDocCommentComment'               , highlight = 0                          , desc = 'xml doc comment - comment'}                ,
  { name = 'XmlDocCommentDelimiter'             , highlight = 0                          , desc = 'xml doc comment - delimiter'}              ,
  { name = 'XmlDocCommentEntityReference'       , highlight = 0                          , desc = 'xml doc comment - entity reference'}       ,
  { name = 'XmlDocCommentName'                  , highlight = 0                          , desc = 'xml doc comment - name'}                   ,
  { name = 'XmlDocCommentProcessingInstruction' , highlight = 0                          , desc = 'xml doc comment - processing instruction'} ,
  { name = 'XmlDocCommentText'                  , highlight = 0                          , desc = 'xml doc comment - text'}                   ,
  { name = 'XmlLiteralAttributeName'            , highlight = 0                          , desc = 'xml literal - attribute name'}             ,
  { name = 'XmlLiteralAttributeQuotes'          , highlight = 0                          , desc = 'xml literal - attribute quotes'}           ,
  { name = 'XmlLiteralAttributeValue'           , highlight = 0                          , desc = 'xml literal - attribute value'}            ,
  { name = 'XmlLiteralCDataSection'             , highlight = 0                          , desc = 'xml literal - cdata section'}              ,
  { name = 'XmlLiteralComment'                  , highlight = 0                          , desc = 'xml literal - comment'}                    ,
  { name = 'XmlLiteralDelimiter'                , highlight = 0                          , desc = 'xml literal - delimiter'}                  ,
  { name = 'XmlLiteralEmbeddedExpression'       , highlight = 0                          , desc = 'xml literal - embedded expression'}        ,
  { name = 'XmlLiteralEntityReference'          , highlight = 0                          , desc = 'xml literal - entity reference'}           ,
  { name = 'XmlLiteralName'                     , highlight = 0                          , desc = 'xml literal - name'}                       ,
  { name = 'XmlLiteralProcessingInstruction'    , highlight = 0                          , desc = 'xml literal - processing instruction'}     ,
  { name = 'XmlLiteralText'                     , highlight = 0                          , desc = 'xml literal - text'}                       ,
  { name = 'RegexComment'                       , highlight = 'OmniSharpRegexComment'    , desc = 'regex - comment'}                          ,
  { name = 'RegexCharacterClass'                , highlight = 0                          , desc = 'regex - character class'}                  ,
  { name = 'RegexAnchor'                        , highlight = 0                          , desc = 'regex - anchor'}                           ,
  { name = 'RegexQuantifier'                    , highlight = 0                          , desc = 'regex - quantifier'}                       ,
  { name = 'RegexGrouping'                      , highlight = 0                          , desc = 'regex - grouping'}                         ,
  { name = 'RegexAlternation'                   , highlight = 0                          , desc = 'regex - alternation'}                      ,
  { name = 'RegexText'                          , highlight = 0                          , desc = 'regex - text'}                             ,
  { name = 'RegexSelfEscapedCharacter'          , highlight = 0                          , desc = 'regex - self escaped character'}           ,
  { name = 'RegexOtherEscape'                   , highlight = 0                          , desc = 'regex - other escape'}
}

local function setup_highlight_groups()
  vim.api.nvim_create_namespace('omnisharp')

  -- TODO: Needs a way to see the current highlight under the cursor.
  -- TODO: Put custom colors into ayu-vim directly

  vim.api.nvim_set_hl(0, 'OmniSharpComment', {link = 'Comment'})
  vim.api.nvim_set_hl(0, 'OmniSharpIdentifier', {link = 'Identifier'})
  vim.api.nvim_set_hl(0, 'OmniSharpKeyword', {link = 'Keyword'})
  vim.api.nvim_set_hl(0, 'OmniSharpControlKeyword', {link = 'Keyword'})
  vim.api.nvim_set_hl(0, 'OmniSharpNumericLiteral', {link = 'Number'})
  vim.api.nvim_set_hl(0, 'OmniSharpOperator', {link = 'Operator'})
  vim.api.nvim_set_hl(0, 'OmniSharpStringLiteral', {link = 'String'})
  vim.api.nvim_set_hl(0, 'OmniSharpText', {link = 'String'})
  vim.api.nvim_set_hl(0, 'OmniSharpClass', {link = 'Type'})
  vim.api.nvim_set_hl(0, 'OmniSharpEnum', {fg = '#91b6ff'})
  vim.api.nvim_set_hl(0, 'OmniSharpInterface', {fg = '#70e6d2'})
  vim.api.nvim_set_hl(0, 'OmniSharpModule', {})
  vim.api.nvim_set_hl(0, 'OmniSharpStruct', {fg = '#6ae693'})
  vim.api.nvim_set_hl(0, 'OmniSharpTypeParameter', {fg = '#aabbee'}) -- NOTE: This is a cool color that fits very well within the ayu color palette. Could be a bit "brighter" maybe.
  vim.api.nvim_set_hl(0, 'OmniSharpConstant', {link = 'Constant'})
  vim.api.nvim_set_hl(0, 'OmniSharpMethod', {link = 'Function'})
  vim.api.nvim_set_hl(0, 'OmniSharpField', {link = 'TSProperty'})
  vim.api.nvim_set_hl(0, 'OmniSharpNamespace', {link = 'Include'})

  vim.api.nvim_set_hl(0, 'OmniSharpRegexComment', {link = 'Comment'})
end

local function highlight_handler(err, result, ctx, config)
  -- NOTE: reset namespace with the following
  local ns_id = vim.api.nvim_get_namespaces()['omnisharp']
  vim.api.nvim_buf_clear_namespace(0, ns_id, 0, -1)

  if err then
    print('ERROR')
    print(err)
    return
  end

  for _,span in pairs(result.Spans) do
    local type = classification_type_names[span.Type + 1] -- convert 0 based index to 1 based index
    if type and type.highlight ~= 0 then
      local startPos = {span.StartLine,span.StartColumn}
      local endPos = {span.EndLine,span.EndColumn}

      -- TODO: See ":h nvim_buf_add_highlight"
      vim.highlight.range(0, ns_id, type.highlight, startPos, endPos, {priority = 1000})
    end
  end
end

local function request_highlight(client)
  local bufnr = vim.api.nvim_get_current_buf()

  local params = {
    fileName = vim.fn.expand('%:p'),
    column = 1,
    line = 1
  }
  client.request('o#/v2/highlight', params, highlight_handler, bufnr)
end

local function setup_highlight_autocmds(config)
  local highlight_callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local clients = vim.lsp.get_active_clients({
      bufnr = bufnr,
      name = 'omnisharp'
    })

    if #clients == 1 then
      local client = clients[1]
      request_highlight(client)
    end
  end

  local bufnr = vim.api.nvim_get_current_buf()
  local highlight_augroup = vim.api.nvim_create_augroup('omnisharp_highlight_' .. tostring(bufnr), {clear = true})
  vim.api.nvim_create_autocmd('BufEnter', {
    group = highlight_augroup,
    buffer = bufnr,
    callback = highlight_callback
  })
  vim.api.nvim_create_autocmd({'InsertLeave', 'TextChanged'}, {
    group = highlight_augroup,
    buffer = bufnr,
    callback = highlight_callback
  })

  if config.highlight.refresh_mode == 'insert' then
    vim.api.nvim_create_autocmd('TextChangedI', {
      group = highlight_augroup,
      buffer = bufnr,
      callback = highlight_callback
    })

    if vim.fn.exists('##TextChangedP') == 1 then
      vim.api.nvim_create_autocmd('TextChangedP', {
        group = highlight_augroup,
        buffer = bufnr,
        callback = highlight_callback
      })
    end
  end
end

return {
  setup = function(opts)
    setup_highlight_groups()

    opts = vim.tbl_extend('force', {
      root_dir = function(path)
        local root_pattern = require('lspconfig.util').root_pattern
        -- Make sure an sln doesn't already exist before trying to use the nearest csproj file
        return root_pattern('*.sln')(path) or root_pattern('*.csproj')(path)
      end,
      handlers = {
        ['textDocument/definition'] = require('omnisharp_extended').handler
      }
    }, opts or {})

    local config = vim.tbl_extend('force', {
      highlight = {
        enabled = true,
        refresh_mode = 'normal' -- 'normal' or 'insert'
      }
    }, opts.config or {})

    if opts.on_attach then
      local existing_attach = opts.on_attach
      opts.on_attach = function(client)
        existing_attach(client)

        if config.highlight then
          setup_highlight_autocmds(config)
          request_highlight(client)
        end
      end
    elseif config.highlight then
      opts.on_attach = function(client)
        setup_highlight_autocmds(config)
        request_highlight(client)
      end
    end

    require('lspconfig').omnisharp.setup(opts)
  end,
  highlight = function()
    local client = vim.lsp.get_client_by_id(1)
    request_highlight(client)
  end
}
