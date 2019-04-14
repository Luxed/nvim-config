" Custom commands
command! -buffer Build :below 10sp term://tsc %:p

" Bindings
noremap <buffer> <F4> :Build<CR>

function! s:GetAngularTsFilePathWithoutExtensions(extension)
  let l:path = split(expand('%:p:r'), '\.spec$')[0]

  return l:path . '.' . a:extension
endfunction

" Angular commands
command! -buffer OpenHtml execute 'edit ' . s:GetAngularTsFilePathWithoutExtensions('html')
command! -buffer OpenCss execute 'edit ' . s:GetAngularTsFilePathWithoutExtensions('css')
command! -buffer OpenTs execute 'edit ' . s:GetAngularTsFilePathWithoutExtensions('ts')
command! -buffer OpenSpec execute 'edit ' . s:GetAngularTsFilePathWithoutExtensions('spec.ts')
command! -buffer Ohtml :OpenHtml
command! -buffer Ocss :OpenCss
command! -buffer Ots :OpenTs
command! -buffer Ospec :OpenSpec
