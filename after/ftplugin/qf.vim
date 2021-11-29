function! s:adjust_height(minheight, maxheight)
  exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
endfunction

" force quickfix to open beneath all other splits
wincmd J

setlocal nonumber
setlocal norelativenumber
setlocal nowrap
setlocal signcolumn=yes
setlocal colorcolumn=
setlocal nobuflisted " quickfix buffers should not pop up when doing :bn or :bp
call s:adjust_height(7, 12)
setlocal winfixheight
setlocal winhighlight=Normal:PanelBackground,SignColumn:PanelBackground,EndOfBuffer:PanelBackground
nnoremap <buffer> H :colder<CR>
nnoremap <buffer> L :cnewer<CR>
