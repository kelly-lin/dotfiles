if exists('g:prettier_dirs_loaded') 
  finish 
endif

let s:save_cpo = &cpo
set cpo&vim

command! Pretty lua require('kl.pretty').Pretty()

let &cpo = s:save_cpo
unlet s:save_cpo

let g:prettier_dirs_loaded = 1
