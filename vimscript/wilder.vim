call wilder#enable_cmdline_enter()
cmap <expr> <Tab> wilder#in_context() ? wilder#next() : "\<Tab>"
cmap <expr> <S-Tab> wilder#in_context() ? wilder#previous() : "\<S-Tab>"
call wilder#set_option('modes', ['/', '?', ':'])

" This allows using the history menu without having the substitution pipeline
" kick in which uses the wildmenu renderer
" @see: https://github.com/gelguy/wilder.nvim/issues/84
let s:always_use_popupmenu = 0
function! s:set_always_use_popupmenu(use, x)
  let s:always_use_popupmenu = a:use
  return a:x
endfunction

call wilder#set_option('pipeline', [
    \ {_, x -> s:set_always_use_popupmenu(0, x)},
    \ wilder#branch(
    \   [
    \     wilder#check({_, x -> empty(x)}),
    \    {_, x -> s:set_always_use_popupmenu(getcmdtype() ==# ':', x)},
    \     wilder#history(),
    \   ],
    \   wilder#python_file_finder_pipeline(#{
    \     file_command: ['rg', '--files'],
    \     filters: ['fuzzy_filter', 'difflib_sorter'],
    \   }),
    \   wilder#substitute_pipeline(#{
    \     pipeline: wilder#python_search_pipeline(#{
    \       skip_cmdtype_check: 1,
    \       pattern: wilder#python_fuzzy_pattern(#{
    \         start_at_boundary: 0,
    \       }),
    \     }),
    \   }),
    \   wilder#cmdline_pipeline(#{
    \     fuzzy: 1,
    \     sorter: wilder#python_difflib_sorter(),
    \     fuzzy_filter: wilder#lua_fzy_filter(),
    \   }),
    \   wilder#python_search_pipeline(#{
    \     pattern: 'fuzzy',
    \   }),
    \ ),
    \])

let s:highlighters = [
  \ wilder#lua_pcre2_highlighter(),
  \ wilder#lua_fzy_highlighter(),
  \]

let s:wildmenu_renderer = wilder#wildmenu_renderer(#{
    \  highlighter: s:highlighters,
    \  separator: ' · ',
    \})

let s:popupmenu_renderer = wilder#popupmenu_renderer(
    \ wilder#popupmenu_border_theme(#{
    \   winblend: 8,
    \   highlights: #{
    \    default: 'Normal',
    \    border: 'NormalFloat',
    \    accent: wilder#make_hl('WilderAccent', 'Normal', 'TabLineSel'),
    \  },
    \  border: 'rounded',
    \  highlighter: s:highlighters,
    \  left: [
    \   wilder#popupmenu_devicons(),
    \   wilder#popupmenu_buffer_flags({
    \     'flags': ' a + ',
    \     'icons': {'+': '', 'a': '', 'h': ''},
    \   }),
    \  ],
    \  right: [' ', wilder#popupmenu_scrollbar()],
    \ })
    \)

call wilder#set_option('renderer', wilder#renderer_mux([
    \ [{-> s:always_use_popupmenu}, s:popupmenu_renderer],
    \ ['substitute', s:wildmenu_renderer],
    \ [':', s:popupmenu_renderer],
    \ ['/', s:wildmenu_renderer],
    \]))
