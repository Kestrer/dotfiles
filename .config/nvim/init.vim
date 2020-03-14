syntax on
set nocompatible " be iMproved
set number " numbered lines
set relativenumber " relative to cursor
set autoread " automatically read if file has changed
set encoding=utf-8 " best encoding
set fileencoding=utf-8
set backspace=indent,eol,start " make backspace work
set autoindent " autoindent based on line above, works most of the time
set smartindent " smarter indent for C-like languages
set tabstop=4 " tabs are 4 spaces
set softtabstop=4
set shiftwidth=4 " when reading, tabs are 4 spaces
set noexpandtab " T A B S
set signcolumn=yes " always show left column
set updatetime=300 " make fast
set ruler " stuff in bottom right
set colorcolumn=100
set textwidth=100

" netrw
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_sort_sequence = ''
let g:netrw_sort_options = 'i'
nnoremap <C-n> :Ex<Enter>

"add closing brace
inoremap {<CR> {<CR>}<Esc>ko
inoremap (<CR> (<CR>)<Esc>ko
inoremap [<CR> [<CR>]<Esc>ko

:command! W w
:command! Q q

" make Y go to end of line (more logical at expense of compatibility)
nmap Y y$
" dd -> X now is the same as cc -> S
nmap X dd

" make ctrl+e and ctrl+y work in insert mode
inoremap <C-e> <C-o><C-e>
inoremap <C-y> <C-o><C-y>

" solarized
set termguicolors
colorscheme NeoSolarized
let g:neosolarized_contrast = "normal"
let g:neosolarized_visibility = "high"
let g:neosolarized_bold = 1
let g:neosolarized_underline = 1
let g:neosolarized_italic = 1
set background=dark

" type #prag in C to get automatic header guards
autocmd FileType c,cpp let fileheader = substitute(substitute(fnamemodify(expand("%"), ":~:."), "/", "_", "g"), "\\.", "_", "g")
autocmd FileType c,cpp inoremap #prag <Esc>:let @f = fileheader<Enter>i#pragma once<Enter>#ifndef <Esc>"fpa<Enter>#define <Esc>"fpa<Enter><Enter><Enter><Enter>#endif<Esc>kki

" type <// while in HTML to autocomplete
autocmd FileType html inoremap <// </<C-X><C-O>

call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

function ConfigureCoc()
	" Use tab for trigger completion with characters ahead and navigate.
	inoremap <silent><expr> <TAB>
		\ pumvisible() ? "\<C-n>" :
		\ <SID>check_back_space() ? "\<TAB>" :
		\ coc#refresh()
	inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
	
	function! s:check_back_space() abort
		let col = col('.') - 1
		return !col || getline('.')[col - 1] =~# '\s'
	endfunction
	
	" <cr> comfirms completion
	inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
	
	" rename
	nmap <leader>rn <Plug>(coc-rename)
	
	" navigate diagnostics
	nmap <silent> [g <Plug>(coc-diagnostic-prev)
	nmap <silent> ]g <Plug>(coc-diagnostic-next)

	" K shows documentation
	nnoremap <silent> K :call <SID>show_documentation()<CR>

	function! s:show_documentation()
		if (index(['vim','help'], &filetype) >= 0)
			execute 'h '.expand('<cword>')
		else
			call CocAction('doHover')
		endif
	endfunction
endfunction
autocmd FileType rust call ConfigureCoc()

" tabs
nnoremap <silent> <M-CR> :tab split<CR>
nnoremap <silent> <M-H> :tabmove -1<CR>
nnoremap <silent> <M-L> :tabmove +1<CR>
nnoremap <silent> <M-l> :tabnext<CR>
nnoremap <silent> <M-h> :tabprevious<CR>
inoremap <silent> <M-CR> <C-o>:tab split<CR>
inoremap <silent> <M-H> <C-o>:tabmove -1<CR>
inoremap <silent> <M-L> <C-o>:tabmove +1<CR>
inoremap <silent> <M-l> <C-o>:tabnext<CR>
inoremap <silent> <M-h> <C-o>:tabprevious<CR>

set tabline=%!MyTabLine()
function GetTabText(tab)
	let tabtext = ''

	let buf = tabpagebuflist(a:tab + 1)[tabpagewinnr(a:tab + 1) - 1]

	let tabtext .= bufname(buf)

	if getbufvar(buf, "&buftype") == 'help'
		let tabtext = fnamemodify(tabtext, ':t') . ' [Help]'
	else
		let tabtext .= ' '
	endif

	if getbufvar(buf, "&readonly")
		let tabtext .= '[RO]'
	endif

	if getbufvar(buf, "&modified")
		let tabtext .= '[+]'
	endif

	if tabtext == ''
		let tabtext = '[No Name]'
	endif

	return tabtext
endfunction

function MyTabLine()
	let tabline = '' " complete tabline goes here
	" loop through each tab page
	for tab in range(tabpagenr('$'))
		" highlight tab if current
		let tabline .= '%#TabLine'
		if tab + 1 == tabpagenr()
			let tabline .= 'Sel'
		endif
		let tabline .= '# ' . GetTabText(tab) . ' '
	endfor
	" after the last tab fill with TabLineFill and reset tab page nr
	let tabline .= '%#TabLineFill#%T'
	return tabline
endfunction
