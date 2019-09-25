set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
" nerdtree
Plugin 'scrooloose/nerdtree'
" solarized
Plugin 'iCyMind/NeoSolarized'

call vundle#end()            " required
filetype plugin indent on    " required

syntax on "syntax highlighting
set number
set relativenumber
set autoread
set encoding=utf-8
set fileencoding=utf-8
set backspace=indent,eol,start
set autoindent    " autoindent based on line above, works most of the time
set smartindent   " smarter indent for C-like languages
set tabstop=4     " tabs are 4 spaces
set softtabstop=4
set shiftwidth=4  " when reading, tabs are 4 spaces
set noexpandtab

" python is weird lol
augroup python
	autocmd!
	autocmd FileType python setlocal noet ts=4
augroup end

autocmd StdinReadPre * let s:std_in=1 "load nerdtree on startup
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

let g:NERDTreeNodeDelimiter = "\u00a0" "replace the ^G in nerdtree with the correct nbsp

inoremap {<CR> {<CR>}<Esc>ko
inoremap (<CR> (<CR>)<Esc>ko
inoremap [<CR> [<CR>]<Esc>ko
"add closing brace

:command! W w
:command! Q q

augroup myvimrchooks
    au!
    autocmd bufwritepost ~/.config/nvim/init.vim source ~/.config/nvim/init.vim
augroup END "automatically reload init.vim

set ruler

nmap Y y$
" make Y go to end of line (more logical at expense of compatibility)
nmap X dd
" dd -> X now is the same as cc -> S

set termguicolors
colorscheme NeoSolarized

" type #prag in C to get automatic header guards
autocmd FileType c let fileheader = substitute(substitute(fnamemodify(expand("%"), ":~:."), "/", "_", "g"), "\\.", "_", "g")
autocmd FileType cpp let fileheader = substitute(substitute(fnamemodify(expand("%"), ":~:."), "/", "_", "g"), "\\.", "_", "g")
autocmd FileType c inoremap #prag <Esc>:let @f = fileheader<Enter>i#pragma once<Enter>#ifndef <Esc>"fpa<Enter>#define <Esc>"fpa<Enter><Enter><Enter><Enter>#endif<Esc>kki
autocmd FileType cpp inoremap #prag <Esc>:let @f = fileheader<Enter>i#pragma once<Enter>#ifndef <Esc>"fpa<Enter>#define <Esc>"fpa<Enter><Enter><Enter><Enter>#endif<Esc>kki

" type <// while in HTML to autocomplete
autocmd FileType html inoremap <// </<C-X><C-O>

