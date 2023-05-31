syntax match VimwikiListTodo '\v(\s+)?(-|\*)\s\[-\]'hs=e-4 conceal cchar=󰄱
syntax match VimwikiListTodo '\v(\s+)?(-|\*)\s\[X\]'hs=e-4 conceal cchar=󰄵 nextgroup=adda skipwhite
syntax match VimwikiListTodo '\v(\s+)?(-|\*)\s\[S\]'hs=e-4 conceal cchar=󰄵 nextgroup=veta skipwhite
syntax match VimwikiListTodo '\v(\s+)?(-|\*)\s\[\.\]'hs=e-4 conceal cchar=󰄱
syntax match VimwikiListTodo '\v(\s+)?(-|\*)\s\[\s\]'hs=e-4 conceal cchar=󰄱
syntax match VimwikiListTodo '\v(\s+)?(-|\*)\s\[o\]'hs=e-4 conceal cchar=󰄱
syntax match VimwikiListTodo '\v(\s+)?(-|\*)\s\[O\]'hs=e-4 conceal cchar=󰄵

syntax match adda '\S.*\ze\s\s[^#]*' contained
syntax match veta '\S.*\ze\s\s[^#]*' contained

hi adda gui=strikethrough
hi veta guifg=#ffffff

"syntax match TaskWikiTaskCompletedText containedin=TaskWikiTask contained contains=@TaskWikiTaskContains /\s*\*\s\[X\]\zs.*\ze\s\s[^#]*/

"hi def link VimwikiListTodo Todo

"hi TaskWikiTaskCompletedCheck guifg=#00ff00

highlight clear Conceal 
highlight link Conceal VimwikiListTodo
