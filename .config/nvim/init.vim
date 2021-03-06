"+------------------------------------------------------------------------------
"|
"| Vim init file (main configuration).
"| Dependend on option: luaFlag (0/1);
"| 0: use neoclide - coc
"| 1: use neovim build in language server capabilities
"|
"+------------------------------------------------------------------------------

let s:luaFlag = 1

if s:luaFlag
lua require('init')

"""function! LSPSetMappings()
"""SLO     setlocal omnifunc=v:lua.vim.lsp.omnifunc
"""SLO     nnoremap <silent> <buffer> K     <cmd>lua vim.lsp.buf.hover()<CR>
"""SLO     nnoremap <silent> <buffer> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
"""SLO     nnoremap <silent> <buffer> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
"""SLO     nnoremap <silent> <buffer> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
"""SLO     nnoremap <silent> <buffer> gr    <cmd>lua vim.lsp.buf.references()<CR>
"""endfunction

"""au FileType c,cpp :call LSPSetMappings()

" completion-nvim
"""SLO inoremap <silent><expr> <c-p> completion#trigger_completion()
" let g:completion_trigger_character = ['.', '>', ':']

"+------------------------------------------------------------------------------
"|
"|                            completion-tree-sitter
"|
"+------------------------------------------------------------------------------
" Configure the completion chains
"SLO let g:completion_chain_complete_list = { 'default' : { 'default' : [ {'complete_items' : ['lsp', 'snippet']}, {'mode' : 'file'} ], 'comment' : [], 'string' : [] }, 'vim' : [ {'complete_items': ['snippet']}, {'mode' : 'cmd'} ], 'c' : [ {'complete_items': ['ts']} ], 'python' : [ {'complete_items': ['ts']} ], 'lua' : [ {'complete_items': ['ts']} ], }
" Highlight the node at point, its usages and definition when cursor holds
"SLO let g:complete_ts_highlight_at_point = 1
" Use completion-nvim in every buffer
"SLO autocmd BufEnter * lua require'completion'.on_attach()

" restore-cursor last-position-jump
autocmd BufReadPost *
	\ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
	\ |   exe "normal! g`\""
	\ | endif

" restore folds
"augroup remember_folds
"	autocmd!
"	autocmd BufWinLeave * mkview
"	autocmd BufWinEnter * silent! loadview
"augroup END
" set foldmethod=indent

"+------------------------------------------------------------------------------
"|
"|                          TODO: Statusline settings
"|
"+------------------------------------------------------------------------------
"""SLO   function! InactiveLine()
"""SLO     return luaeval("require'nvimConfig.statusLine'.inActiveLine()")
"""SLO   endfunction
"""SLO   function! ActiveLine()
"""SLO     return luaeval("require'nvimConfig.statusLine'.activeLine()")
"""SLO   endfunction
  " Change statusline automatically
"""SLO   augroup Statusline
"""SLO     autocmd!
"""SLO     autocmd WinEnter,BufEnter * setlocal statusline=%!ActiveLine()
"""SLO     autocmd WinLeave,BufLeave * setlocal statusline=%!InactiveLine()
"""SLO   augroup END
"""SLO   function! TabLine()
"""SLO     return luaeval("require'nvimConfig.statusLine'.TabLine()")
"""SLO   endfunction
"""SLO   set tabline=%!TabLine()

  " TODO: Vim-Plug plugins still in use
"""SLO   runtime! init/vimPlugLua.vim

	" Graphviz configuration
	" How to open the generated output file. If does not exist, graphviz.vim 
	" will automatically choose the right way depending on the platform.
	" let g:graphviz_viewer = 'evince'
	" let g:graphviz_viewer = 'inkscape'
"""SLO 	let g:graphviz_viewer = 'eog'

	" Default output format. Default is 'pdf'.
	" let g:graphviz_output_format = 'pdf'
	" let g:graphviz_output_format = 'svg'
"""SLO 	let g:graphviz_output_format = 'png'

	" Options passed on to dot. Default is ''.
"""SLO 	let g:graphviz_shell_option = ''

  " TODO: Neovide settings
"""SLO   if exists('g:neovide')
    " do neovide specific config
"""SLO     set guifont=InconsolataLGC:h16
"""SLO 		set mouse="a"
"""SLO   endif

"" """ autocmd Filetype python setlocal omnifunc=v:lua.vim.lsp.omnifunc
"" autocmd Filetype cpp setlocal omnifunc=v:lua.vim.lsp.omnifunc
"" autocmd Filetype lua setlocal omnifunc=v:lua.vim.lsp.omnifunc
"" 
"" nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
"" nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
"" nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
"" nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
"" nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
"" nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
"" nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
else
  " Neovim specific configuration file
  runtime! init/neovide.vim
  runtime! init/statusLine.vim
  runtime! init/pythonProvider.vim
  runtime! init/rubyHost.vim
  runtime! init/vimPlug.vim
  runtime! init/coc.vim
  runtime! init/devProject.vim
  runtime! init/vimLsp.vim
  runtime! init/general.vim
  runtime! init/switchBuffer.vim
  runtime! init/vista.vim
  """ runtime! init/indentLine.vim
  """ runtime! init/luaTerminal.vim
  """ runtime! init/nvim-example-lua-plugin.vim
  """ runtime! init/cocTemplates.vim
  """ runtime! init/cocSnippets.vim
  """ runtime! init/findR.vim
  """ runtime! init/bashTerm.vim
  """ runtime! init/inActiveWindowColors.vim
  "" runtime! init/snippetsLua.vim
  "" runtime! init/snippets.vim
  "" runtime! init/doge.vim
endif
