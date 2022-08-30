" Add autocompletion
lua require('dap.ext.autocompl').attach()

function! s:adjust_height(minheight, maxheight)
  exe max([min([line("$"), a:maxheight]), a:minheight]) . 'wincmd _'
endfunction

setlocal nobuflisted " dap repl buffers should not pop up when doing :bn or :bp
call s:adjust_height(10, 15)

setlocal winfixheight
setlocal signcolumn=yes
setlocal colorcolumn=
