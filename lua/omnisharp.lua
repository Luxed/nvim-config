local classification_type_names = {
  { name = 'Comment'                            , highlight = 'Comment'         , desc = 'comment'}                                  ,
  { name = 'ExcludedCode'                       , highlight = 0                 , desc = 'excluded code'}                            ,
  { name = 'Identifier'                         , highlight = 0                 , desc = 'identifier'}                               ,
  { name = 'Keyword'                            , highlight = 0                 , desc = 'keyword'}                                  ,
  { name = 'ControlKeyword'                     , highlight = 0                 , desc = 'keyword - control'}                        ,
  { name = 'NumericLiteral'                     , highlight = 0                 , desc = 'number'}                                   ,
  { name = 'Operator'                           , highlight = 0                 , desc = 'operator'}                                 ,
  { name = 'OperatorOverloaded'                 , highlight = 0                 , desc = 'operator - overloaded'}                    ,
  { name = 'PreprocessorKeyword'                , highlight = 0                 , desc = 'preprocessor keyword'}                     ,
  { name = 'StringLiteral'                      , highlight = 0                 , desc = 'string'}                                   ,
  { name = 'WhiteSpace'                         , highlight = 0                 , desc = 'whitespace'}                               ,
  { name = 'Text'                               , highlight = 0                 , desc = 'text'}                                     ,
  { name = 'StaticSymbol'                       , highlight = 0                 , desc = 'static symbol'}                            ,
  { name = 'PreprocessorText'                   , highlight = 0                 , desc = 'preprocessor text'}                        ,
  { name = 'Punctuation'                        , highlight = 0                 , desc = 'punctuation'}                              ,
  { name = 'VerbatimStringLiteral'              , highlight = 0                 , desc = 'string - verbatim'}                        ,
  { name = 'StringEscapeCharacter'              , highlight = 0                 , desc = 'string - escape character'}                ,
  { name = 'ClassName'                          , highlight = 'OSCLassName'     , desc = 'class name'}                               ,
  { name = 'DelegateName'                       , highlight = 'Structure'       , desc = 'delegate name'}                            ,
  { name = 'EnumName'                           , highlight = 'OSEnumName'      , desc = 'enum name'}                                ,
  { name = 'InterfaceName'                      , highlight = 'OSInterfaceName' , desc = 'interface name'}                           ,
  { name = 'ModuleName'                         , highlight = 0                 , desc = 'module name'}                              ,
  { name = 'StructName'                         , highlight = 0                 , desc = 'struct name'}                              ,
  { name = 'TypeParameterName'                  , highlight = 'OSTypeParameterName', desc = 'type parameter name'}                      ,
  { name = 'FieldName'                          , highlight = 'OSField'         , desc = 'field name'}                               ,
  { name = 'EnumMemberName'                     , highlight = 0                 , desc = 'enum member name'}                         ,
  { name = 'ConstantName'                       , highlight = 'Constant'        , desc = 'constant name'}                            ,
  { name = 'LocalName'                          , highlight = 0                 , desc = 'local name'}                               ,
  { name = 'ParameterName'                      , highlight = 0                 , desc = 'parameter name'}                           ,
  { name = 'MethodName'                         , highlight = 'Function'        , desc = 'method name'}                              ,
  { name = 'ExtensionMethodName'                , highlight = 'Function'        , desc = 'extension method name'}                    ,
  { name = 'PropertyName'                       , highlight = 'OSField'         , desc = 'property name'}                            ,
  { name = 'EventName'                          , highlight = 0                 , desc = 'event name'}                               ,
  { name = 'NamespaceName'                      , highlight = 'Include'         , desc = 'namespace name'}                           ,
  { name = 'LabelName'                          , highlight = 0                 , desc = 'label name'}                               ,
  { name = 'XmlDocCommentAttributeName'         , highlight = 0                 , desc = 'xml doc comment - attribute name'}         ,
  { name = 'XmlDocCommentAttributeQuotes'       , highlight = 0                 , desc = 'xml doc comment - attribute quotes'}       ,
  { name = 'XmlDocCommentAttributeValue'        , highlight = 0                 , desc = 'xml doc comment - attribute value'}        ,
  { name = 'XmlDocCommentCDataSection'          , highlight = 0                 , desc = 'xml doc comment - cdata section'}          ,
  { name = 'XmlDocCommentComment'               , highlight = 0                 , desc = 'xml doc comment - comment'}                ,
  { name = 'XmlDocCommentDelimiter'             , highlight = 0                 , desc = 'xml doc comment - delimiter'}              ,
  { name = 'XmlDocCommentEntityReference'       , highlight = 0                 , desc = 'xml doc comment - entity reference'}       ,
  { name = 'XmlDocCommentName'                  , highlight = 0                 , desc = 'xml doc comment - name'}                   ,
  { name = 'XmlDocCommentProcessingInstruction' , highlight = 0                 , desc = 'xml doc comment - processing instruction'} ,
  { name = 'XmlDocCommentText'                  , highlight = 0                 , desc = 'xml doc comment - text'}                   ,
  { name = 'XmlLiteralAttributeName'            , highlight = 0                 , desc = 'xml literal - attribute name'}             ,
  { name = 'XmlLiteralAttributeQuotes'          , highlight = 0                 , desc = 'xml literal - attribute quotes'}           ,
  { name = 'XmlLiteralAttributeValue'           , highlight = 0                 , desc = 'xml literal - attribute value'}            ,
  { name = 'XmlLiteralCDataSection'             , highlight = 0                 , desc = 'xml literal - cdata section'}              ,
  { name = 'XmlLiteralComment'                  , highlight = 0                 , desc = 'xml literal - comment'}                    ,
  { name = 'XmlLiteralDelimiter'                , highlight = 0                 , desc = 'xml literal - delimiter'}                  ,
  { name = 'XmlLiteralEmbeddedExpression'       , highlight = 0                 , desc = 'xml literal - embedded expression'}        ,
  { name = 'XmlLiteralEntityReference'          , highlight = 0                 , desc = 'xml literal - entity reference'}           ,
  { name = 'XmlLiteralName'                     , highlight = 0                 , desc = 'xml literal - name'}                       ,
  { name = 'XmlLiteralProcessingInstruction'    , highlight = 0                 , desc = 'xml literal - processing instruction'}     ,
  { name = 'XmlLiteralText'                     , highlight = 0                 , desc = 'xml literal - text'}                       ,
  { name = 'RegexComment'                       , highlight = 0                 , desc = 'regex - comment'}                          ,
  { name = 'RegexCharacterClass'                , highlight = 0                 , desc = 'regex - character class'}                  ,
  { name = 'RegexAnchor'                        , highlight = 0                 , desc = 'regex - anchor'}                           ,
  { name = 'RegexQuantifier'                    , highlight = 0                 , desc = 'regex - quantifier'}                       ,
  { name = 'RegexGrouping'                      , highlight = 0                 , desc = 'regex - grouping'}                         ,
  { name = 'RegexAlternation'                   , highlight = 0                 , desc = 'regex - alternation'}                      ,
  { name = 'RegexText'                          , highlight = 0                 , desc = 'regex - text'}                             ,
  { name = 'RegexSelfEscapedCharacter'          , highlight = 0                 , desc = 'regex - self escaped character'}           ,
  { name = 'RegexOtherEscape'                   , highlight = 0                 , desc = 'regex - other escape'}
}

local function setup_highlight_groups()
  vim.api.nvim_create_namespace('omnisharp')

  vim.api.nvim_set_hl(0, 'OSClassName', {fg = '#FF0000'})
  vim.api.nvim_set_hl(0, 'OSEnumName', {fg = '#00FF00'})
  vim.api.nvim_set_hl(0, 'OSInterfaceName', {fg = '#F0E000'})
  vim.api.nvim_set_hl(0, 'OSModuleName', {fg = '#00F0F0'})
  vim.api.nvim_set_hl(0, 'OSTypeParameterName', {fg = '#F000A0'})
  vim.api.nvim_set_hl(0, 'OSField', {fg = '#cbf0f7'})
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

-- TODO: For highlighting, Omnisharp uses the "BufEnter", "InsertLeave,TextChanged", "TextChangedI" and "TextChangedP" autocommands
local function request_highlight(client)
  local bufnr = vim.api.nvim_get_current_buf()

  local params = {
    fileName = vim.fn.expand('%:p'),
    column = 1,
    line = 1
  }
  client.request('o#/v2/highlight', params, highlight_handler, bufnr)
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

    if opts.on_attach then
      local existing_attach = opts.on_attach
      opts.on_attach = function(client)
        existing_attach(client)

        request_highlight(client)
      end
    else
      opts.on_attach = function(client)
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
