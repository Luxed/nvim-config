(local nvim (require :aniseed.nvim))

(local list-of-terms {})

(fn create-term [name command]
  (let [term {
              :name name
              :command command
              :buffer nil
              }]
    term))

(fn isloaded-term [term]
  (and term.buffer (nvim.buf_is_loaded term.buffer)) )

(fn switch-term [term]
  (if (isloaded-term term)
    (nvim.set_current_buf term.buffer)
    (let [buf (nvim.create_buf false false)]
      (nvim.set_current_buf buf)
      (nvim.call_function "termopen" [ term.command ])
      (tset term "buffer" buf)))
  nil)

(fn add [name command]
  (if (not (. list-of-terms name))
    (let [term (create-term name command)]
      (tset list-of-terms name term)))
  (switch-term (. list-of-terms name))
  nil)

(fn create-command [name command]
  (.. "lua require('terminal').Named('" name "', '" command "')"))

{
 :Named add
 :CreateCommand create-command
 }
