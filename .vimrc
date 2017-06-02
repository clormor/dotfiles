set nocompatible              " be iMproved, required
"filetype off                  " required

execute pathogen#infect()
filetype plugin indent on
syntax on

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'LaTeX-Box-Team/LaTeX-Box'

" All of your Plugins must be added before the following line
call vundle#end()            " required

set number
:syntax on
set background=dark
"
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smarttab
set expandtab
set autoindent
"
set viminfo='100,h
"
map <F2> :set number!<CR>
map <F3> :set autoindent!<CR>
map <F4> :set spell! spelllang=en_us<CR>
map <F5> <ESC>:1,$!xmllint --format -<CR>

command Lm Latexmk

" LaTeX:
let g:tex_flavor='latex'
autocmd FileType tex set wrap linebreak
let g:LatexBox_latexmk_async=0
let g:LatexBox_latexmk_preview_continuously=1
let g:LatexBox_quickfix=2
let g:LaTeXBox_output_type='' "Let latexmkrc choose the type 
let s:extfname = expand("%:e")
if s:extfname ==? "tex"
    let g:LatexBox_split_type="new"
    let g:LatexBox_latexmk_preview_continuously=1
    let g:LatexBox_quickfix=2
endif

au BufReadCmd *.jar,*.xpi,*.par call zip#Browse(expand("<amatch>"))
