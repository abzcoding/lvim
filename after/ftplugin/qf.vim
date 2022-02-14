function! AdjustWindowHeight(minheight, maxheight)
  execute max([a:minheight, min([line('$'), a:maxheight])]) . 'wincmd _'
endfunction

" force quickfix to open beneath all other splits
wincmd J

setlocal nonumber
setlocal norelativenumber
setlocal nowrap
setlocal signcolumn=yes
setlocal colorcolumn=
setlocal nobuflisted " quickfix buffers should not pop up when doing :bn or :bp
call AdjustWindowHeight(7, 15)
setlocal winfixheight
setlocal winhighlight=Normal:PanelBackground,SignColumn:PanelBackground,EndOfBuffer:PanelBackground
nnoremap <buffer> H :colder<CR>
nnoremap <buffer> L :cnewer<CR>
