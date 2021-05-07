let s:message_file_extension = 'Enter file extension: '

function! switcher#Switch()
    let l:ext = input(s:message_file_extension)
    if l:ext ==# ''
        return
    endif

    call switcher#OpenNewPath(l:ext)
endfunction

function! switcher#SwitchWithOptions(options)
    if type(a:options) != v:t_dict
        echoerr 'options needs to be a dictionnary'
        return
    endif

    let l:ext = input(s:message_file_extension)
    if l:ext ==# ''
        return
    endif

    let l:ext_option = {'extension': l:ext}
    let l:test = extend(l:ext_option, a:options)

    call switcher#OpenNewPath(l:ext_option)
endfunction

function! switcher#OpenNewPath(options)
    let edit_command = 'edit'
    let cwd = expand('%:p:h')
    let filename = expand('%:t:r')

    let ext = ''

    if type(a:options) == v:t_string
      let ext = a:options
    elseif type(a:options) == v:t_dict
      if has_key(a:options, 'extension')
        let ext = a:options['extension']
      endif

      if has_key(a:options, 'remove')
        let filename = substitute(filename, a:options['remove'], '', 'g')
      endif

      if has_key(a:options, 'subdir')
        let cwd += '/' . a:options['subdir']
      endif

      if has_key(a:options, 'edit_command')
          let edit_command = a:options['edit_command']
      endif
    endif

    execute edit_command . ' ' . cwd . '/' . filename . '.' . ext
endfunction
