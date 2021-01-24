local gl = require('galaxyline')
local gls = gl.section

local colors = {
  bg = '#282c34',
  yellow = '#fabd2f',
  cyan = '#008080',
  darkblue = '#081633',
  green = '#afd700',
  orange = '#FF8800',
  purple = '#5d4d7a',
  magenta = '#d16d9e',
  grey = '#c0c0c0',
  blue = '#0087d7',
  red = '#ec5f67'
}

-- not happy with this
--[[if vim.g.colors_name == 'ayu' then
  colors.bg = '#232834'
  colors.yellow = '#FFCC66'
  colors.cyan = '#5CCFE6'
  colors.darkblue = '#399EE6'
  colors.green = '#BAE67E'
  colors.orange = '#FFA759'
  colors.purple = '#A34ACC'
  colors.magenta = '#D4BFFF'
  colors.grey = '#CBCCC6'
  colors.blue = '#77A8D9'
  colors.red = '#F28779'
end]]

local function buffer_not_empty()
  return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
end
local function checkwidth()
  local squeeze_width  = vim.fn.winwidth(0) / 2
  return squeeze_width > 40
end
local function get_icon_color()
  local file_name = vim.fn.expand('%:t')
  local file_ext = vim.fn.expand('%:e')

  local _, icon_hl = require('nvim-web-devicons').get_icon(file_name, file_ext, { default = true })
  local hl_id = vim.fn.hlID(icon_hl)
  local hl_hex_color = vim.fn.synIDattr(hl_id, 'fg#')

  return hl_hex_color
end
local function has_lsp_clients()
  return #vim.lsp.buf_get_clients() > 0
end
local function ts_whitelist()
  local whitelist_filetype = { rust = true }
  return whitelist_filetype[vim.bo.filetype]
end

gls.left[1] = {
  FirstElement = {
    provider = function() return ' ' end,
    highlight = {colors.yellow,colors.yellow}
  },
}
gls.left[2] = {
  ViMode = {
    provider = function()
      local alias = {
        n      = 'NORMAL',
        i      = 'INSERT',
        c      = 'COMMAND',
        R      = 'REPLACE',
        t      = '>_',
        v      = 'VISUAL',
        V      = 'V-LINE',
        [''] = 'V-BLOCK',
      }
      return alias[vim.fn.mode()]
    end,
    separator = '',
    separator_highlight = {
      colors.yellow,
      function()
        if not buffer_not_empty() then
          return colors.purple
        end
        return colors.darkblue
      end
    },
    highlight = {colors.magenta, colors.yellow, 'bold'},
  },
}
gls.left[3] = {
  FileIcon = {
    provider = 'FileIcon',
    condition = buffer_not_empty,
    highlight = {
      get_icon_color,
      colors.darkblue
    },
  },
}
gls.left[4] = {
  FileName = {
    provider = {'FileName','FileSize'},
    condition = buffer_not_empty,
    separator = '',
    separator_highlight = {colors.purple,colors.darkblue},
    highlight = {colors.magenta,colors.darkblue}
  }
}
gls.left[5] = {
  GitIcon = {
    provider = function() return '  ' end,
    condition = buffer_not_empty,
    highlight = {colors.orange,colors.purple},
  }
}
gls.left[6] = {
  GitBranch = {
    provider = 'GitBranch',
    condition = buffer_not_empty,
    highlight = {colors.grey,colors.purple},
  }
}
gls.left[7] = {
  DiffAdd = {
    provider = 'DiffAdd',
    condition = checkwidth,
    icon = '',
    highlight = {colors.green,colors.purple},
  }
}
gls.left[8] = {
  DiffModified = {
    provider = 'DiffModified',
    condition = checkwidth,
    icon = '',
    highlight = {colors.orange,colors.purple},
  }
}
gls.left[9] = {
  DiffRemove = {
    provider = 'DiffRemove',
    condition = checkwidth,
    icon = '',
    highlight = {colors.red,colors.purple},
  }
}
gls.left[10] = {
  LeftEnd = {
    provider = function() return '' end,
    separator = '',
    separator_highlight = {colors.purple,colors.bg},
    highlight = {colors.purple,colors.purple}
  }
}

gls.right = {
  {
    TreeSitter = {
      provider = function()
        return require('nvim-treesitter').statusline(40)
      end,
      condition = ts_whitelist,
      separator = '',
      separator_highlight = {
        colors.bg,
        function()
          return has_lsp_clients() and colors.purple or colors.darkblue
        end
      },
      highlight = {
        colors.grey,
        function()
          return has_lsp_clients() and colors.purple or colors.darkblue
        end
      }
    }
  },
  {
    LspStatus = {
      provider = function()
        return require('lsp-status').status()
      end,
      condition = has_lsp_clients,
      separator = '',
      separator_highlight = {
        colors.darkblue,
        --colors.bg
        function()
          return ts_whitelist() and colors.purple or colors.bg
        end
      },
      highlight = {colors.grey, colors.darkblue},
    }
  },
  {
    FileFormat = {
      provider = 'FileFormat',
      separator = '',
      separator_highlight = {
        function()
          return (has_lsp_clients() or ts_whitelist()) and colors.darkblue or colors.bg
        end,
        colors.purple
      },
      highlight = {colors.grey,colors.purple},
    }
  },
  {
    LineInfo = {
      provider = 'LineColumn',
      separator = ' | ',
      separator_highlight = {colors.darkblue,colors.purple},
      highlight = {colors.grey,colors.purple},
    }
  },
  {
    PerCent = {
      provider = 'LinePercent',
      separator = '',
      separator_highlight = {colors.darkblue,colors.purple},
      highlight = {colors.grey,colors.darkblue},
    }
  },
  {
    ScrollBar = {
      provider = 'ScrollBar',
      highlight = {colors.yellow,colors.purple},
    }
  },
}

gls.short_line_left[1] = {
  BufferType = {
    provider = 'FileTypeName',
    separator = '',
    separator_highlight = {colors.purple,colors.bg},
    highlight = {colors.grey,colors.purple}
  }
}
gls.short_line_left[2] = {
  SpaceShort = {
    provider = function () return ' ' end,
    highlight = {colors.bg, colors.bg}
  }
}
gls.short_line_left[3] = {
  FileNameShort = {
    provider = {'FileName','FileSize'},
    highlight = {colors.grey, colors.bg}
  }
}

gls.short_line_right[1] = {
  BufferIcon = {
    provider= 'BufferIcon',
    separator = '',
    separator_highlight = {colors.purple, colors.bg},
    highlight = {colors.grey, colors.purple}
  }
}
