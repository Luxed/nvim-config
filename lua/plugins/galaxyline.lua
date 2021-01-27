local gl = require('galaxyline')
local gls = gl.section
local lsp_status = require('lsp-status')

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
local function get_git_logo_color()
  local _, icon_hl = require('nvim-web-devicons').get_icon('git', 'git', { default = true })
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

-- Colors from ayu_mirage.vim from the "vim-airline-themes" repository
local function mode_color()
  local mode = vim.fn.mode()

  if mode == 'i' then
    return '#80d4ff'
  elseif mode == 'v' or mode == 'V' or mode == '' then
    return '#ffae57'
  elseif mode == 'R' then
    return '#f07178'
  elseif mode == 'c' then
    return '#d4bfff'
  end
  return '#bbe67e'
end

local colors_ayu = {
  light_bg = '#232834',
  dark_bg = '#141925',
  light_fg = '#cbccc6',
  dark_fg = '#232834'
}

local current_mode = vim.fn.mode()
gls.left = {
  {
    FirstElement = {
      provider = function() return ' ' end,
      highlight = {colors_ayu.dark_fg, mode_color}
    },
  },
  {
    ViMode = {
      provider = function()
        local mode = vim.fn.mode()
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
        if current_mode ~= mode then
          require('galaxyline.colors').init_theme(function() return gls end)
          current_mode = mode
        end
        return alias[mode]
      end,
      separator = '',
      separator_highlight = {
        mode_color,
        function()
          if not buffer_not_empty() then
            return colors_ayu.dark_bg
          end
          return colors_ayu.light_bg
        end
      },
      highlight = {colors_ayu.dark_fg, mode_color, 'bold'},
    }
  },
  {
    FileIcon = {
      provider = 'FileIcon',
      condition = buffer_not_empty,
      highlight = {get_icon_color, colors_ayu.light_bg}
    },
  },
  {
    FileName = {
      provider = 'FileName',
      condition = buffer_not_empty,
      highlight = {mode_color, colors_ayu.light_bg}
    }
  },
  {
    FileType = {
      provider = function()
        local ft = vim.bo.filetype
        return ' (' .. ft .. ')'
      end,
      condition = function()
        local ft = vim.bo.filetype
        local ext = vim.fn.expand('%:e')

        return buffer_not_empty() and ft ~= '' and ft ~= ext
      end,
      highlight = {mode_color, colors_ayu.light_bg}
    }
  },
  {
    BeforeGitSeparator = {
      provider = function() return '' end,
      condition = buffer_not_empty,
      separator = '',
      separator_highlight = {colors_ayu.dark_bg, colors_ayu.light_bg},
    }
  },
  {
    GitIcon = {
      provider = function() return '  ' end,
      condition = buffer_not_empty,
      highlight = {get_git_logo_color, colors_ayu.dark_bg},
    }
  },
  {
    GitBranch = {
      provider = 'GitBranch',
      condition = buffer_not_empty,
      highlight = {colors_ayu.light_fg, colors_ayu.dark_bg},
    }
  },
  {
    DiffAdd = {
      provider = 'DiffAdd',
      condition = checkwidth,
      icon = '',
      highlight = {'#bbe67e', colors_ayu.dark_bg}, -- fg from DiffAdd
    }
  },
  {
    DiffModified = {
      provider = 'DiffModified',
      condition = checkwidth,
      icon = '',
      highlight = {'#5ccfe6', colors_ayu.dark_bg}, -- fg from DiffChange
    }
  },
  {
    DiffRemove = {
      provider = 'DiffRemove',
      condition = checkwidth,
      icon = '',
      highlight = {'#F28779', colors_ayu.dark_bg}, -- fg from DiffDelete
    }
  },
  {
    LeftEnd = {
      provider = function() return '' end,
      separator = '',
      separator_highlight = {colors_ayu.dark_bg, '#212733'}, -- bg from Normal
      highlight = {colors_ayu.dark_bg, colors_ayu.dark_bg}
    }
  }
}

gls.right = {
  {
    TreeSitter = {
      provider = function() return require('nvim-treesitter').statusline(40) end,
      condition = ts_whitelist,
      separator = '',
      separator_highlight = {
        '#212733', -- fg is bg from Normal
        function()
          return has_lsp_clients() and colors_ayu.light_bg or colors_ayu.dark_bg
        end
      },
      highlight = {
        colors_ayu.light_fg,
        function()
          return has_lsp_clients() and colors_ayu.light_bg or colors_ayu.dark_bg
        end
      }
    }
  },
  {
    LspStatus = {
      --provider = require('lsp-status').status,
      provider = function()
        return lsp_status.status()
      end,
      condition = has_lsp_clients,
      separator = '',
      separator_highlight = {
        colors_ayu.dark_bg,
        function()
          return ts_whitelist() and colors_ayu.light_bg or '#212733'
        end
      },
      highlight = {colors_ayu.light_fg, colors_ayu.dark_bg},
    }
  },
  {
    FileFormat = {
      provider = 'FileFormat',
      separator = '',
      separator_highlight = {
        function()
          return (has_lsp_clients() or ts_whitelist()) and colors_ayu.dark_bg or '#212733'
        end,
        colors_ayu.light_bg
      },
      highlight = {colors_ayu.light_fg, colors_ayu.light_bg},
    }
  },
  {
    LineInfo = {
      provider = 'LineColumn',
      separator = ' | ',
      separator_highlight = {colors_ayu.dark_bg, colors_ayu.light_bg},
      highlight = {colors_ayu.light_fg, colors_ayu.light_bg},
    }
  },
  {
    PerCent = {
      provider = 'LinePercent',
      separator = '',
      separator_highlight = {colors_ayu.dark_bg, colors_ayu.light_bg},
      highlight = {colors_ayu.light_fg, colors_ayu.dark_bg},
    }
  },
  {
    ScrollBar = {
      provider = 'ScrollBar',
      highlight = {mode_color, colors_ayu.light_bg},
    }
  },
}

gls.short_line_left = {
  {
    BufferType = {
      provider = 'FileTypeName',
      separator = '',
      separator_highlight = {colors_ayu.dark_bg, colors_ayu.light_bg},
      highlight = {colors_ayu.light_fg, colors_ayu.dark_bg}
    }
  },
  {
    SpaceShort = {
      provider = function () return ' ' end,
      highlight = {colors_ayu.light_bg, colors_ayu.light_bg}
    }
  },
  {
    FileNameShort = {
      provider = {'FileName','FileSize'},
      highlight = {colors_ayu.light_fg, colors_ayu.light_bg}
    }
  }
}

gls.short_line_right = {
  {
    BufferIcon = {
      provider= 'BufferIcon',
      separator = '',
      separator_highlight = {colors_ayu.dark_bg, colors_ayu.light_bg},
      highlight = {colors_ayu.light_fg, colors_ayu.dark_bg}
    }
  }
} 
