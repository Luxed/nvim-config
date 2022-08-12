local classification_type_names = {
  { name = 'Comment'                            } ,
  { name = 'ExcludedCode'                       } ,
  { name = 'Identifier'                         } ,
  { name = 'Keyword'                            } ,
  { name = 'ControlKeyword'                     } ,
  { name = 'NumericLiteral'                     } ,
  { name = 'Operator'                           } ,
  { name = 'OperatorOverloaded'                 } ,
  { name = 'PreprocessorKeyword'                } ,
  { name = 'StringLiteral'                      } ,
  { name = 'WhiteSpace'                         } ,
  { name = 'Text'                               } ,
  { name = 'StaticSymbol'                       } ,
  { name = 'PreprocessorText'                   } ,
  { name = 'Punctuation'                        } ,
  { name = 'VerbatimStringLiteral'              } ,
  { name = 'StringEscapeCharacter'              } ,
  { name = 'ClassName'                          } ,
  { name = 'DelegateName'                       } ,
  { name = 'EnumName'                           } ,
  { name = 'InterfaceName'                      } ,
  { name = 'ModuleName'                         } ,
  { name = 'StructName'                         } ,
  { name = 'TypeParameterName'                  } ,
  { name = 'FieldName'                          } ,
  { name = 'EnumMemberName'                     } ,
  { name = 'ConstantName'                       } ,
  { name = 'LocalName'                          } ,
  { name = 'ParameterName'                      } ,
  { name = 'MethodName'                         } ,
  { name = 'ExtensionMethodName'                } ,
  { name = 'PropertyName'                       } ,
  { name = 'EventName'                          } ,
  { name = 'NamespaceName'                      } ,
  { name = 'LabelName'                          } ,
  { name = 'XmlDocCommentAttributeName'         } ,
  { name = 'XmlDocCommentAttributeQuotes'       } ,
  { name = 'XmlDocCommentAttributeValue'        } ,
  { name = 'XmlDocCommentCDataSection'          } ,
  { name = 'XmlDocCommentComment'               } ,
  { name = 'XmlDocCommentDelimiter'             } ,
  { name = 'XmlDocCommentEntityReference'       } ,
  { name = 'XmlDocCommentName'                  } ,
  { name = 'XmlDocCommentProcessingInstruction' } ,
  { name = 'XmlDocCommentText'                  } ,
  { name = 'XmlLiteralAttributeName'            } ,
  { name = 'XmlLiteralAttributeQuotes'          } ,
  { name = 'XmlLiteralAttributeValue'           } ,
  { name = 'XmlLiteralCDataSection'             } ,
  { name = 'XmlLiteralComment'                  } ,
  { name = 'XmlLiteralDelimiter'                } ,
  { name = 'XmlLiteralEmbeddedExpression'       } ,
  { name = 'XmlLiteralEntityReference'          } ,
  { name = 'XmlLiteralName'                     } ,
  { name = 'XmlLiteralProcessingInstruction'    } ,
  { name = 'XmlLiteralText'                     } ,
  { name = 'RegexComment'                       } ,
  { name = 'RegexCharacterClass'                } ,
  { name = 'RegexAnchor'                        } ,
  { name = 'RegexQuantifier'                    } ,
  { name = 'RegexGrouping'                      } ,
  { name = 'RegexAlternation'                   } ,
  { name = 'RegexText'                          } ,
  { name = 'RegexSelfEscapedCharacter'          } ,
  { name = 'RegexOtherEscape'                   }
                                                }

local hl_ns = 'omnisharp_semantic'

local function create_namespace()
  vim.api.nvim_create_namespace(hl_ns)
end

local function get_namespace()
  return vim.api.nvim_get_namespaces()[hl_ns]
end

local function get_group_name(type_name)
  return 'OmniSharp' .. type_name
end

local M = {}

-- TODO: Needs a way to see the current highlight under the cursor.
M.__setup_highlight_groups = function(config)
  create_namespace()

  for _, type in pairs(classification_type_names) do
    local group_name = get_group_name(type.name)
    local definition_map = config.highlight.groups[group_name] or {}

    vim.api.nvim_set_hl(0, group_name, definition_map)
  end
end

M.__highlight_handler = function(err, result, ctx, config)
  -- NOTE: reset namespace with the following
  local ns_id = get_namespace()
  vim.api.nvim_buf_clear_namespace(0, ns_id, 0, -1)

  if err then
    print('ERROR')
    print(err)
    return
  end

  for _,span in pairs(result.Spans) do
    local type = classification_type_names[span.Type + 1] -- convert 0 based index to 1 based index
    if type then
      local startPos = {span.StartLine,span.StartColumn}
      local endPos = {span.EndLine,span.EndColumn}
      local group_name = get_group_name(type.name)

      vim.highlight.range(0, ns_id, group_name, startPos, endPos, {priority = 300})
    end
  end
end

return M
