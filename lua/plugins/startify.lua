local g = vim.g

-- ensure vim-startify is loaded
vim.cmd('packadd vim-startify')

g['startify_change_to_dir'] = 0
g['startify_custom_header'] = {
  [[  _   _                 _           ]],
  [[ | \ | |               (_)          ]],
  [[ |  \| | ___  _____   ___ _ __ ___  ]],
  [[ | . ` |/ _ \/ _ \ \ / / | '_ ` _ \ ]],
  [[ | |\  |  __/ (_) \ V /| | | | | | |]],
  [[ |_| \_|\___|\___/ \_/ |_|_| |_| |_|]],
  [[                                    ]],
  unpack(vim.fn['startify#fortune#boxed']())
}
g['startify_lists'] = {
  { type = 'dir',       header = {'   MRU ' .. vim.fn.getcwd()} },
  { type = 'files',     header = {'   MRU'                    } },
  { type = 'sessions',  header = {'   Sessions'               } },
  { type = 'bookmarks', header = {'   Bookmarks'              } },
  { type = 'commands',  header = {'   Commands'               } },
}

