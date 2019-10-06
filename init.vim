set nocompatible              " be iMproved

syntax on "syntax highlighting
set number
set relativenumber
set autoread
set encoding=utf-8
set fileencoding=utf-8
set backspace=indent,eol,start " make backspace work
set autoindent    " autoindent based on line above, works most of the time
set smartindent   " smarter indent for C-like languages
set tabstop=4     " tabs are 4 spaces
set softtabstop=4
set shiftwidth=4  " when reading, tabs are 4 spaces
set noexpandtab

" netrw
" Press V to open file
" P to open file in old window
let g:netrw_browse_split = 0
let g:netrw_winsize = 90
let g:netrw_banner = 0
let g:netrw_altv = 1
let g:netrw_liststyle = 3

" python is weird lol
augroup python
	autocmd!
	autocmd FileType python setlocal noet ts=4
augroup end

"add closing brace
inoremap {<CR> {<CR>}<Esc>ko
inoremap (<CR> (<CR>)<Esc>ko
inoremap [<CR> [<CR>]<Esc>ko

:command! W w
:command! Q q

" automatically reload init.vim
augroup myvimrchooks
    au!
    autocmd bufwritepost ~/.config/nvim/init.vim source ~/.config/nvim/init.vim
augroup END 

set ruler

" make Y go to end of line (more logical at expense of compatibility)
nmap Y y$
" dd -> X now is the same as cc -> S
nmap X dd

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
autocmd FileType c let fileheader = substitute(substitute(fnamemodify(expand("%"), ":~:."), "/", "_", "g"), "\\.", "_", "g")
autocmd FileType cpp let fileheader = substitute(substitute(fnamemodify(expand("%"), ":~:."), "/", "_", "g"), "\\.", "_", "g")
autocmd FileType c inoremap #prag <Esc>:let @f = fileheader<Enter>i#pragma once<Enter>#ifndef <Esc>"fpa<Enter>#define <Esc>"fpa<Enter><Enter><Enter><Enter>#endif<Esc>kki
autocmd FileType cpp inoremap #prag <Esc>:let @f = fileheader<Enter>i#pragma once<Enter>#ifndef <Esc>"fpa<Enter>#define <Esc>"fpa<Enter><Enter><Enter><Enter>#endif<Esc>kki

" type <// while in HTML to autocomplete
autocmd FileType html inoremap <// </<C-X><C-O>
