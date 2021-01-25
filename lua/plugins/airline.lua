local g = vim.g

g['airline_powerline_fonts'] = 1
g['airline#extensions#tabline#enabled'] = 1
g['airline#extensions#tabline#fnamemod'] = ':t'
g['airline#extensions#tabline#tab_nr_type'] = 1
g['airline#extensions#tabline#show_tab_nr'] = 1
g['airline_mode_map'] = {
  ['__'] = '------',
  ['c']  = 'COMMAND',
  ['i']  = 'INSERT',
  ['ic'] = 'INSERT',
  ['ix'] = 'INSERT',
  ['n']  = 'NORMAL',
  ['ni'] = '(INSERT)',
  ['no'] = 'OP PENDING',
  ['R']  = 'REPLACE',
  ['Rv'] = 'V REPLACE',
  ['s']  = 'SELECT',
  ['S']  = 'S-LINE',
  [''] = 'S-BLOCK',
  ['t']  = '>_',
  ['v']  = 'VISUAL',
  ['V']  = 'V-LINE',
  [''] = 'V-BLOCK',
}
