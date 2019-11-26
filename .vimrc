set nocompatible

filetype on
filetype plugin on
filetype indent on
syntax on

function SetPathogen()
    " see https://github.com/tpope/vim-pathogen
    if !empty(glob("~/.vim/autoload/pathogen.vim"))
        execute pathogen#infect()
    endif
endfunction

function SetVundle()
    " see https://github.com/VundleVim/Vundle.vim
    if !empty(glob("~/.vim/bundle/Vundle.vim"))
        set rtp+=~/.vim/bundle/Vundle.vim
        call vundle#begin()
        Plugin 'VundleVim/Vundle.vim'
        " if not yet installed, launch vim and run :PluginInstall
        Plugin 'LaTeX-Box-Team/LaTeX-Box'
        call vundle#end()
    endif
endfunction

function SetDefaultKeyMappings()
    map <F2> :set number!<CR>
    map <F4> :set spell! spelllang=en_gb<CR>
    map <F5> <ESC>:1,$!xmllint --format -<CR>
    nnoremap <F3> :set invpaste paste?<CR>
    set pastetoggle=<F3>
endfunction

function SetDefaultSettings()
    set number
    :syntax on
    set background=dark
    set tabstop=4
    set softtabstop=4
    set shiftwidth=4
    set smarttab
    set expandtab
    set autoindent
    set showmode
    set ruler
    set viminfo='100,h
endfunction

function SetLatexOptions()
    command Lm Latexmk
    let g:tex_flavor='latex'
    set wrap linebreak
    let g:LatexBox_latexmk_async=0
    let g:LatexBox_latexmk_preview_continuously=1
    let g:LatexBox_quickfix=2
    let g:LaTeXBox_output_type=''
    let s:extfname = expand("%:e")
    if s:extfname ==? "tex"
        let g:LatexBox_split_type="new"
        let g:LatexBox_latexmk_preview_continuously=1
        let g:LatexBox_quickfix=2
    endif
endfunction

function SetWidthTo80()
    set textwidth=80
    set colorcolumn=80
    highlight ColorColumn ctermbg=0 guibg=lightgrey
    " don't wrap a word over multiple lines
    set wrap linebreak
endfunction

function SetMarkdownOptions()
    call SetWidthTo80()
    " don't continue comment on new lines
    set formatoptions+=t
endfunction

function SetShellOptions()
    call SetWidthTo80()
endfunction

function SetYamlOptions()
    setlocal ts=2 sts=2 sw=2 expandtab
endfunction

function SetZipOptions()
    " allow opening of zip files including jars/pars
    call zip#Browse(expand("<amatch>"))
endfunction

call SetPathogen()
call SetVundle()
call SetDefaultKeyMappings()
call SetDefaultSettings()

" treat jars/pars as zip files
au BufReadCmd *.jar,*.xpi,*.par call SetZipOptions()

" ensure we configure yml and yaml files the same way
autocmd FileType yaml call SetYamlOptions()
autocmd FileType yml call SetYamlOptions()

autocmd FileType sh call SetShellOptions()

" make sure we correctly detect markdown files
au BufNewFile,BufRead *.markdown,*.mdown,*.mkd,*.mkdn,*.mdwn,README.md  setf markdown
autocmd Filetype markdown call SetMarkdownOptions()
