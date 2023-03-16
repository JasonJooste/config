" NORMAL_SETTINGS -------------------------------------------------------------------------------- {{{
" Disble vi compatibility
set nocompatible
" Enable type file detection.
filetype on
filetype indent on
" Turn on syntax highlighting
syntax on
" Add line numbers and highlighting
set number
set cursorline
set cursorcolumn
" Show the mode
set showmode
" Make the command history longer
set history=1337
" Make the clipboard share properly
set clipboard=unnamedplus
" }}}

" PLUGINS----------------------------------------------------------------------------------------- {{{ 
call plug#begin()
" Markdown files
Plug 'godlygeek/tabular' | Plug 'preservim/vim-markdown'
" Markdown preview
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
call plug#end()

" }}}
" PLUGIN SETTINGS--------------------------------------------------------------------------------- {{{
"------------------------------------------------------------------------------------------------------
"iamcco/markdown-preview 
"------------------------------------------------------------------------------------------------------
let g:mkdp_refresh_slow=1
" Make it look like github
let g:mkdp_markdown_css='~/.vim/github_markdown.css'
"------------------------------------------------------------------------------------------------------
" plasticboy/vim-markdown 
"------------------------------------------------------------------------------------------------------
" Makes sure that all markdown is shown (some stuff is hidden by default)
autocmd FileType markdown let conceallevel=0
" }}}
"
" MAPPINGS --------------------------------------------------------------- {{{

" Mappings code goes here.

" }}}


" VIMSCRIPT -------------------------------------------------------------- {{{

" This will enable code folding.
" Use the marker method of folding.
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" More Vimscripts code goes here.

" }}}


" STATUS LINE ------------------------------------------------------------ {{{

" Status bar code goes here.

" }}}
