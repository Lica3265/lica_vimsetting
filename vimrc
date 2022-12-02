"--------------
" Plugins
"--------------
call plug#begin('~/.vim/plugged')
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'mattn/emmet-vim'

  " for general purpose development
  Plug 'tomtom/tcomment_vim'
  Plug 'christoomey/vim-tmux-navigator'  
  Plug 'tomtom/tlib_vim'
  Plug 'majutsushi/tagbar'
  Plug 'mileszs/ack.vim'
  Plug 'airblade/vim-gitgutter'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } 
  Plug 'junegunn/fzf.vim'
  Plug 'vim-scripts/cscope.vim'

  " for vue.js development   
  Plug 'leafOfTree/vim-vue-plugin'

call plug#end()

"--------------
" Settings
"--------------
set number
set nocompatible
set clipboard=unnamed
set noswapfile
set hidden
set nobomb            " no BOM(Byte Order Mark)
set mouse=a

"--------------
" Filetype and Encoding
"--------------
filetype on
filetype indent on
filetype plugin on

" file encoding
set encoding=utf-8
scriptencoding utf-8

"--------------
" key mapping
"--------------

" WSL yank support
let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
endif