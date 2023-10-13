local aw_section = {
  function()
    return require('aw_watcher').is_connected() and '祥' or '精'
  end,
  cond = function()
    local has_aw, _ = pcall(require, 'aw_watcher')
    return has_aw
  end
}

local wpm_section = {
  function ()
    local wpm = require('wpm')
    return wpm.wpm() .. ' ' .. wpm.historic_graph()
  end
}

local mixed_indent_section = {
  function()
    local space_pat = [[\v^ +]]
    local tab_pat = [[\v^\t+]]
    local space_indent = vim.fn.search(space_pat, 'nwc')
    local tab_indent = vim.fn.search(tab_pat, 'nwc')
    local mixed = (space_indent > 0 and tab_indent > 0)
    local mixed_same_line

    if not mixed then
      mixed_same_line = vim.fn.search([[\v^(\t+ | +\t)]], 'nwc')
      mixed = mixed_same_line > 0
    end

    if not mixed then
      return ''
    end

    if mixed_same_line ~= nil and mixed_same_line > 0 then
      return 'MI:' .. mixed_same_line
    end

    local space_indent_cnt = vim.fn.searchcount({ pattern = space_pat, max_count = 1e3 }).total
    local tab_indent_cnt = vim.fn.searchcount({ pattern = tab_pat, max_count = 1e3 }).total

    if space_indent_cnt > tab_indent_cnt then
      return 'MI:' .. tab_indent
    else
      return 'MI:' .. space_indent
    end
  end
}

local trailing_whitespace_section = {
  function()
    local space = vim.fn.search([[\s\+$]], 'nwc')
    return space ~= 0 and "TW:" .. space or ""
  end,
  cond = function()
    return vim.bo.filetype ~= 'markdown' and vim.fn.mode() == 'n'
  end
}

local wordcount_section = {
  function()
    local wordcount = vim.fn.wordcount()
    return 'WC: ' .. wordcount.words
  end,
  cond = function()
    return vim.bo.filetype == 'markdown'
  end
}

local winbar = {
  lualine_c = {
    {
      function()
        return vim.fn.expand('%:t')
      end,
      cond = function()
        return require('nvim-navic').is_available()
      end
    },
    {
      function()
        return require('nvim-navic').get_location({
          highlight = true,
        })
      end,
      cond = function()
        return require('nvim-navic').is_available()
      end
    },
  }
}

return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'SmiteshP/nvim-navic',
  },
  config = function()
    require('lualine').setup({
      sections = {
        lualine_x = {
          wpm_section,
          'encoding',
          'fileformat',
          'filetype',
          aw_section,
        },
        lualine_y = {
          wordcount_section,
          'progress'
        },
        lualine_z = {
          trailing_whitespace_section,
          mixed_indent_section,
          'location'
        }
      },
      winbar = winbar,
      inactive_winbar = winbar,
      extensions = { 'fugitive', 'neo-tree' },
      options = {
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
      }
    })
  end,
}
