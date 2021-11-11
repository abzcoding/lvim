" Vim syntax file
" Add checkboxes to *.md files
" source: https://gist.github.com/huytd/668fc018b019fbc49fa1c09101363397
" based on: https://www.reddit.com/r/vim/comments/h8pgor/til_conceal_in_vim/
" youtube video: https://youtu.be/UuHJloiDErM?t=793

" Custom conceal (does not work with existing syntax highlight plugin)
syntax match todoCheckbox "\v.*\[\ \]"hs=e-2 conceal cchar=
syntax match todoCheckbox "\v.*\[x\]"hs=e-2 conceal cchar=
setlocal conceallevel=2

highlight Conceal guibg=NONE

"https://vi.stackexchange.com/a/4003/16249
syntax match NoSpellAcronym '\<\(\u\|\d\)\{3,}s\?\>' contains=@NoSpell
