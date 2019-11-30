(local list-of-terms {})

(fn create-term [name command]
  (let [term {
              :name name
              :command command
              :buffer nil
              }]
    term))

(fn isloaded-term [term]
  (and term.buffer (vim.api.nvim_buf_is_loaded term.buffer)) )

(fn switch-term [term]
  (if (isloaded-term term)
    (vim.api.nvim_set_current_buf term.buffer)
    (let [buf (vim.api.nvim_create_buf false false)]
      (vim.api.nvim_set_current_buf buf)
      (vim.api.nvim_call_function "termopen" [ term.command ])
      (tset term "buffer" buf))
    )
  nil)

(fn add [name command]
  (if (not (. list-of-terms name))
    (let [term (create-term name command)]
      (tset list-of-terms name term)))
  (switch-term (. list-of-terms name))
  nil)

{ :Named add }
